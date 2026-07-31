local M = {}

M.keys = {

    -- authenticate
    {
        "<leader>ma", "<CMD>Codeium Auth<CR>",
        mode = 'n', desc = "Authenticate to Windsurf"
    },

    -- enable
    {
        "<leader>me", "<CMD>Codeium Enable<CR>",
        mode = 'n', desc = "Enable Windsurf"
    },
    {
        "<leader>mbe", "<CMD>Codeium EnableBuffer<CR>",
        mode = 'n', desc = "Enable Windsurf in the current buffer"
    },

}

M.config = function()

    -- disable
    vim.keymap.set('n', "<leader>md", "<CMD>Codeium Disable<CR>", {
        desc = "Disable Windsurf"
    })
    vim.keymap.set('n', "<leader>mbd", "<CMD>Codeium DisableBuffer<CR>", {
        desc = "Disable Windsurf in the current buffer"
    })

    -- cycle through suggestions
    vim.keymap.set(
        'n', "<leader>mn", "<CMD>call codeium#CycleCompletions(1)<CR>", {
            desc = "Cycle to the next Windsurf suggestion"
        }
    )
    vim.keymap.set(
        'n', "<leader>mp", "<CMD>call codeium#CycleCompletions(-1)<CR>", {
            desc = "Cycle to the previous Windsurf suggestion"
        }
    )
    vim.keymap.set(
        'i', "<C-f>", "<CMD>call codeium#CycleCompletions(1)<CR>", {
            desc = "Cycle to the next Windsurf suggestion"
        }
    )
    vim.keymap.set(
        'i', "<C-b>", "<CMD>call codeium#CycleCompletions(-1)<CR>", {
            desc = "Cycle to the previous Windsurf suggestion"
        }
    )

    -- cancel / accept suggestion
    vim.keymap.set(
        'n',
        "<C-c>",
        "<CMD>silent! call codeium#Clear()<CR><CMD>nohlsearch<CR>", {
            desc = "Clear Windsurf suggestion", silent = true
        }
    )
    vim.keymap.set('i', "<Tab>", "codeium#Accept()", {
        desc = "Accept Windsurf suggestion",
        expr = true,
        script = true,
        silent = true,
        nowait = true
    })

end

return M

