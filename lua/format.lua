local cmd = require("utils.cmd")
local wnd = require("utils.wnd")

-- encoding
vim.scriptencoding = 'utf-8'
vim.opt.encoding = 'utf-8'
vim.opt.fileencoding = 'utf-8'

-- comments
vim.opt.formatoptions:append { 'r' } -- auto insert comment leader
vim.opt.formatoptions:append { 'j' } -- remove comment leader when joining lines

-- line breaks
vim.opt.wrap = false
vim.opt.breakindent = true
vim.opt.autoindent = true
vim.opt.smarttab = true
vim.opt.colorcolumn = "81" -- the color column indicates border, not limit

-- whitespace
vim.opt.shiftwidth = 4
vim.opt.tabstop = 4
vim.opt.expandtab = true

if not wnd.is_terminal() then
    -- find a local formatter configuration and store it to prefer it later,
    -- but skip if we are in the browser or some IDE that knows how to format
    nvimbued.configured_formatters = (function()
        -- local dir = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(0), ":h")
        local dir = vim.fn.getcwd()
        -- NOTE(martin-braun): It would be ok to execute this for each buffer,
        -- but it would be slow. We compromise by using the cwd, so always
        -- `cd` in your project when attempting to format files there.
        local sep = package.config:sub(1, 1)
        local formatters = {}
        while dir ~= sep do
            local files = vim.fn.readdir(dir)
            for _, file in ipairs(files) do
                if vim.fn.filereadable(dir .. sep .. file) == 1 then
                    if file == ".rustfmt.toml" or file == "rustfmt.toml" then
                        table.insert(formatters, "rustfmt")
                    end
                    if file == ".dprint.json" or file == "dprint.json" then
                        table.insert(formatters, "dprint")
                    end
                    if file == ".prettierrc"
                        or file == "prettierrc.json"
                        or file == "prettierrc.yml"
                        or file == "prettierrc.yaml"
                        or file == "prettierrc.json5"
                        or file == "prettierrc.js"
                        or file == "prettier.config.js"
                        or file == "prettierrc.ts"
                        or file == "prettier.config.ts"
                        or file == "prettierrc.mjs"
                        or file == "prettier.config.mjs"
                        or file == "prettierrc.mts"
                        or file == "prettier.config.mts"
                        or file == "prettierrc.cjs"
                        or file == "prettier.config.cjs"
                        or file == "prettierrc.cts"
                        or file == "prettier.config.cts"
                        or file == "prettierrc.toml" then
                        table.insert(formatters, "prettier")
                    end
                    if file == "analysis_options.yaml" then
                        table.insert(formatters, "dart")
                    end
                end
            end
            if #formatters > 0 then
                return formatters
            end
            dir = vim.fn.fnamemodify(dir, ":h")
        end
        return nil
    end)()
end

