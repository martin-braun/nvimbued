local maps = require("maps.telescope_maps")
local wnd = require("utils.wnd")
local M = { "nvim-telescope/telescope.nvim" }
M.main = "telescope"
M.branch = "0.1.x"
M.cond = wnd.is_terminal()
M.dependencies = { 'nvim-lua/plenary.nvim' }

M.lazy = true
M.keys = maps.keys

M.opts = {
    defaults = {
        mappings = {
            n = {
                ["<C-q>"] = function(self)
                    require('telescope.actions').close(self)
                end,
            },
            i = {
                ["<C-q>"] = function(self)
                    require('telescope.actions').close(self)
                end,
            },
            -- NOTE(martin-braun): We 'require' in a lambda expression to
            -- prevent loading the plugin immediately
        },
        vimgrep_arguments = {
            "rg",
            "--color=never",
            "--no-heading",
            "--with-filename",
            "--line-number",
            "--column",
            "--smart-case",
            "--follow",
            "--hidden",
        },
        file_ignore_patterns = {
            ".git/",
            "node_modules",
            "__pycache__",
            "venv",
        },
        sorting_strategy = "ascending", -- display results top->bottom
        layout_strategy = "dynamic",
        layout_config = {
            height = 0.95,
            prompt_position = "top",
            vertical = {
                mirror = true,
                preview_cutoff = 0,
            },
        },
    },
}

M.config = function()
    -- dynamic layout strategy depending on the number of columns
    local layout_strategies = require(M.main .. ".pickers.layout_strategies")
    layout_strategies.dynamic = function(
        self, max_columns, max_lines, layout_config)
        if vim.o.columns > 120 then
            return layout_strategies.horizontal(
                self, max_columns, max_lines, layout_config
            )
        else
            return layout_strategies.vertical(
                self, max_columns, max_lines, layout_config
            )
        end
    end
    require(M.main).setup(M.opts)
end

return M

