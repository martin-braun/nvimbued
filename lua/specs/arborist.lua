local wnd = require("utils.wnd")
local M = { "arborist-ts/arborist.nvim" }
M.main = "arborist"
M.cond = wnd.is_terminal()

M.lazy = false

M.opts = {
    update_cadence = "daily",
    install_popular = false,
    prefer_wasm = false,
    concurrency = 1,
    ensure_installed = {
        "bash",
        "regex",
        -- c, lua, vim and markdown are already boundled with NeoVim
    },
    disable = {
        -- indent = { "markdown" },
        -- highlight = { "csv" },
    },
    overrides = {
        -- my_language = { url = "https://github.com/me/tree-sitter-my-language" },
    },
}

return M

