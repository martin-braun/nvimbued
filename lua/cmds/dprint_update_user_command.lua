local updating = false

local function report_error(message)
    vim.api.nvim_echo({ { "dprint update failed: " .. message, "ErrorMsg" } }, true, {})
end

vim.api.nvim_create_user_command(
    'DprintUpdate',
    function()
        if updating then
            return
        end
        local executable = nvimbued.prgs.dprint
        if not executable then
            report_error("dprint executable not found")
            return
        end

        local stdout = ""
        local stderr = ""
        updating = true
        local ok, job = pcall(vim.fn.jobstart, {
            executable, "config", "update", "--yes", "--config",
            -- Always update this Neovim config, not the current project's config.
            vim.fn.stdpath("config") .. "/dprint.json"
        }, {
            stdout_buffered = true,
            stderr_buffered = true,
            on_stdout = function(_, data)
                stdout = vim.trim(table.concat(data, "\n"))
            end,
            on_stderr = function(_, data)
                stderr = vim.trim(table.concat(data, "\n"))
            end,
            on_exit = function(_, code)
                vim.schedule(function()
                    updating = false
                    if code ~= 0 then
                        local detail = stderr ~= "" and stderr or stdout
                        local message = "exit code " .. code
                        if detail ~= "" then
                            message = message .. ": " .. detail
                        end
                        report_error(message)
                    else
                        vim.api.nvim_echo({ { "dprint plugins updated" } }, true, {})
                    end
                end)
            end
        })
        if not ok or job <= 0 then
            updating = false
            local message = ok and ("could not start process (" .. job .. ")")
                or tostring(job)
            report_error(message)
        end
    end,
    { nargs = 0, bang = false, desc = 'Update dprint plugins for this Neovim configuration' }
)
