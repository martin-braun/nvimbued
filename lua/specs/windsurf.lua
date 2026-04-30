local wnd = require("utils.wnd")
local maps = require("maps.windsurf_maps")

local M = { "Exafunction/windsurf.vim" }
M.main = "codeium"
M.cond = wnd.is_terminal()
-- M.dependencies = { -- only when using the nvim plugin
--     "nvim-lua/plenary.nvim",
--     "hrsh7th/nvim-cmp",
-- },

M.lazy = true
M.keys = maps.keys

M.opts = {}

M.config = function()
    --require(M.main).setup(M.opts) -- only when using the nvim plugin variant
    maps.config()
end

return M

