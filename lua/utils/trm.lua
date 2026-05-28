local M = {}

local shells = {
    bash = true,
    sh = true,
    ash = true,
    dash = true,
    zsh = true,
    fish = true,
    ksh = true,
    mksh = true,
}

local function proc_name(pid)
    local out = vim.fn.systemlist({ "ps", "-p", tostring(pid), "-o", "comm=" })
    return out[1] and vim.trim(out[1]):match("([^/]+)$")
end

local function has_children(pid)
    local out = vim.fn.systemlist({ "ps", "-axo", "ppid=" })
    for _, ppid in ipairs(out) do
        if tonumber(ppid) == pid then
            return true
        end
    end
    return false
end

M.buf_any_busy = function()
    for _, bufnr in ipairs(vim.api.nvim_list_bufs()) do
        if vim.api.nvim_buf_is_loaded(bufnr) and vim.bo[bufnr].buftype == "terminal" then
            local channel = vim.bo[bufnr].channel
            if channel > 0 and vim.fn.jobwait({ channel }, 0)[1] == -1 then
                local pid = vim.fn.jobpid(channel)
                local name = proc_name(pid)
                if pid <= 0 or not shells[name] or has_children(pid) then
                    return true
                end
            end
        end
    end
    return false
end

return M
