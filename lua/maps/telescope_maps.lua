local M = {}

M.keys = {
    -- open home
    {
        "<leader><CR>", "<CMD>Telescope<CR>",
        mode = 'n', desc = "Open Telescope"
    },

    -- resume last action
    {
        "<leader>rr",
        "<CMD>Telescope resume<CR>",
        mode = 'n', desc = "Resume last Telescope action"
    },

    -- navigate buffers
    {
        "<leader>b", "<CMD>Telescope buffers<CR>",
        mode = 'n', desc = "Navigate open buffers"
    },

    -- find files
    {
        "<leader>e",
        "<CMD>Telescope find_files hidden=true no_ignore=false<CR>",
        mode = 'n', desc = "Find files"
    },
    {
        "<C-Space>",
        "<CMD>tabnew<CR>" ..
        "<CMD>Telescope find_files hidden=true no_ignore=false<CR>",
        mode = 'n', desc = "Find files"
    },
    {
        "<leader>E",
        "<CMD>Telescope find_files hidden=true no_ignore=true<CR>",
        mode = 'n', desc = "Find files"
    },
    {
        "<leader><leader>e",
        "<CMD>Telescope find_files hidden=true no_ignore=true<CR>",
        mode = 'n', desc = "Find files"
    },
    {
        "<leader><C-Space>",
        "<CMD>tabnew<CR>" ..
        "<CMD>Telescope find_files hidden=true no_ignore=true<CR>",
        mode = 'n', desc = "Find files"
    },

    -- search files
    {
        "<C-7>", "<CMD>Telescope live_grep<CR>",
        mode = 'n', desc = "Search files"
    },
    {
        "<C-_>", "<CMD>Telescope live_grep<CR>",
        mode = 'n', desc = "Search files"
    },
    {
        "<leader><C-7>",
        "<CMD>Telescope live_grep " ..
        "vimgrep_arguments=rg," ..
        "--color=never," ..
        "--no-heading," ..
        "--no-heading," ..
        "--line-number," ..
        "--column," ..
        "--smart-case," ..
        "--follow," ..
        "--hidden," ..
        "--no-ignore" ..
        "<CR>",
        mode = 'n', desc = "Search hidden files"
    },
    {
        "<leader><C-_>",
        "<CMD>Telescope live_grep " ..
        "vimgrep_arguments=rg," ..
        "--color=never," ..
        "--no-heading," ..
        "--no-heading," ..
        "--line-number," ..
        "--column," ..
        "--smart-case," ..
        "--follow," ..
        "--hidden," ..
        "--no-ignore" ..
        "<CR>",
        mode = 'n', desc = "Search hidden files"
    },
    -- NOTE(martin-braun): <C-_> seem to be <C-7>, both are kept for clarity.

    -- search keymaps
    {
        "<leader>fk", "<CMD>Telescope keymaps<CR>",
        mode = 'n', desc = "Find keymaps"
    },
    -- (also as default command palette)
    {
        "<C-p>", "<CMD>Telescope keymaps<CR>",
        mode = 'n', desc = "Command Palette"
    },

    -- git
    {
        "<leader>g", "<CMD>Telescope git_status<CR>",
        mode = 'n', desc = "Show Git Status"
    },
    {
        "<leader>G", "<CMD>Telescope git_commits<CR>",
        mode = 'n', desc = "Show Git Commits"
    },

}

return M

