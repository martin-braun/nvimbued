local wnd = require("utils.wnd")

-- revert Y to full line copy to mimic vim, use y$ instead
vim.cmd("nunmap Y")

-- prevent window close from <C-w><C-c>
vim.keymap.set('n', "<C-w><C-c>", "<nop>")

-- disable exit help and clear highlights
vim.keymap.set('n', "<C-c>", "<CMD>nohlsearch<CR>", {
    desc = "Clear find highlights"
})

-- list open buffers
vim.keymap.set('n', "<leader>b", "<CMD>ls<CR>", { desc = "List open buffers" })

-- refresh / reload buffer
vim.keymap.set('n',"<leader>R","<CMD>checktime<CR>", {
    desc = "Refresh buffer"
})

-- create terminal buffer (only works when not in a tmux session)
vim.keymap.set('n', "<C-t>", "<CMD>terminal<CR>", {
    desc = "Create terminal buffer"
})

-- create terminal buffer and attach
vim.keymap.set('n', "<leader>tt", "<CMD>terminal<CR>a", {
    desc = "Create terminal buffer"
})
vim.keymap.set('n', "<leader>ts", "<CMD>split<CR><CMD>wincmd j<CR><CMD>terminal<CR>a", {
    desc = "Create terminal buffer after horizontal split"
})
vim.keymap.set('n', "<leader>tv", "<CMD>vsplit<CR><CMD>wincmd l<CR><CMD>terminal<CR>a", {
    desc = "Create terminal buffer after vertical split"
})

-- exit terminal
vim.keymap.set('t', "<Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })

-- create file buffer
vim.keymap.set('n', "<leader>c", "<CMD>ene<CR>", {
    desc = "Create file buffer"
})
vim.keymap.set('n', "<leader>e", ":e ", {
    desc = "Open file in curent buffer"
})

-- delete buffer
vim.keymap.set('n', "<leader>x", "<CMD>bd<CR>", { desc = "Delete buffer" })

-- force delete buffer
vim.keymap.set('n', "<leader>X", "<CMD>bd!<CR>", {
    desc = "Force delete buffer"
})

-- format buffer
vim.keymap.set('n', "<leader>ff", "gg=G''zz", { desc = "Format buffer" })
-- INFO(martin-braun): changing this requires you to patch ./lua/utils/fmt.lua

-- rename in buffer
vim.keymap.set(
    'n',
    "<leader>rn",
    ":%s/\\V\\<<C-R><C-W>\\>//gc<left><left><left>",
    { desc = "Rename in buffer" }
)

-- yank relative file path of buffer
vim.keymap.set(
    'n',
    "<leader>yf",
    '<CMD>let @+=expand("%")<CR>',
    { desc = "Yank relative file path of buffer" }
)

-- yank absolute file path of buffer
vim.keymap.set(
    'n',
    "<leader>yF",
    '<CMD>let @+=expand("%:p")<CR>',
    { desc = "Yank absolute file path of buffer" }
)

-- save buffer
vim.keymap.set('n', "<C-s>", "<CMD>w<CR>", { desc = "Save buffer" })

if wnd.is_terminal() then

    -- save all buffers and store session
    vim.keymap.set(
        'n',
        "<leader>ss",
        "<CMD>wa<CR><CMD>BufQuitHidden<CR><CMD>mks!<CR>",
        {
            desc = "Save all buffers, wipe hidden buffers and store session"
        }
    )

    -- save all buffers, quit hidden buffers, store session and quit
    vim.keymap.set(
        'n',
        "ZZ",
        "<CMD>wa<CR><CMD>BufQuitHidden<CR><CMD>mks!<CR><CMD>BufExitGuard<CR><CMD>qa<CR>", {
            desc = "Save all buffers, wipe hidden buffers, " .. "store session and quit"
        }
    )

else

    -- save all buffers
    vim.keymap.set('n', "<leader>ss", "<CMD>wa<CR>", {
        desc = "Save all buffers"
    })

    -- save all buffers and quit
    vim.keymap.set('n', "ZZ", "<CMD>wa<CR><CMD>qa<CR>", {
        desc = "Save all buffers and quit"
    })

end

-- toggle line numbers in buffer
vim.keymap.set('n', "<leader>L", "<CMD>set nonumber! norelativenumber!<CR>", {
    desc = "Toggle line numbers" }
)

-- quit all buffers
vim.keymap.set('n', "ZQ", "<CMD>BufExitGuard<CR><CMD>qa!<CR>", {
    desc = "Delete all buffers and quit" }
)

if wnd.is_terminal() then
    -- tab management does not make sense in other environments than the term,
    -- i.e. a browser hooks only one buffer per element, or
    -- an IDE has its own tab management, etc.

    -- create tab
    vim.keymap.set('n', "<leader>tc", "<CMD>tabnew<CR>", {
        desc = "Create tab"
    })
    vim.keymap.set('n', "<C-n>", "<CMD>tabnew<CR>", { desc = "Create tab" })

    -- next tab navigation
    vim.keymap.set('n', "<leader>tn", "<CMD>tabn<CR>", { desc = "Next tab" })
    vim.keymap.set('n', "<leader>n", "<CMD>tabn<CR>", { desc = "Next tab" })
    vim.keymap.set('n', "<C-j>", "<CMD>tabn<CR>", { desc = "Next tab" })

    -- previous tab navigation
    vim.keymap.set('n', "<leader>tp", "<CMD>tabp<CR>", { desc = "Previous tab" })
    vim.keymap.set('n', "<leader>p", "<CMD>tabp<CR>", { desc = "Previous tab" })
    vim.keymap.set('n', "<C-k>", "<CMD>tabp<CR>", { desc = "Previous tab" })

    -- move tab forward
    vim.keymap.set('n', "<leader>j", "<CMD>tabm +1<CR>", {
        desc = "Move tab forward"
    })

    -- move tab backward
    vim.keymap.set('n', "<leader>k", "<CMD>tabm -1<CR>", {
        desc = "Move tab backward"
    })

    -- close current tab
    vim.keymap.set('n', "<leader>tq", "<CMD>tabc<CR>", {
        desc = "Close current tab"
    })
    vim.keymap.set('n', "<leader>tx", "<CMD>tabc<CR>", {
        desc = "Close current tab"
    })
    vim.keymap.set('n', "<C-q>", "<CMD>tabc<CR>", { desc = "Close current tab" })

    -- close other tabs
    vim.keymap.set('n', "<leader>to", "<CMD>tabo<CR>" , {
        desc = "Close other tabs"
    })

end

-- smart window split
vim.keymap.set('n', "<C-w>s", "<CMD>split<CR><CMD>wincmd j<CR>" , {
    desc = "Horizontally split window and auto-focus"
})
vim.keymap.set('n', "<C-w>v", "<CMD>vsplit<CR><CMD>wincmd l<CR>" , {
    desc = "Vertically split window and auto-focus"
})

-- grow window horizontally
vim.keymap.set('n', "<C-w>+", "8<C-w>+", { desc = "Grow window horizontally" })

-- shrink window horizontally
vim.keymap.set('n', "<C-w>-", "8<C-w>-", {
    desc = "Shrink window horizontally"
})

-- minimize window horizontally
vim.keymap.set('n', "<C-w>_", "32<C-w>|", {
    desc = "Minimize window horizontally"
})

-- grow window vertically
vim.keymap.set('n', "<C-w>>", "8<C-w>>", { desc = "Grow window vertically" })

-- shrink window vertically
vim.keymap.set('n', "<C-w><", "8<C-w><", { desc = "Shrink window vertically" })

-- grow window vertically
vim.keymap.set('n', "<C-w>|", "32<C-w>_", {
    desc = "Minimize window vertically"
})

-- yank inner backticks
vim.keymap.set('n', "y´", "yi`", {
    desc = "Yank inner backticks"
})

if wnd.is_terminal() then

    -- open netrw
    vim.keymap.set('n', "<C-e>", "<CMD>Ex %:p:h<CR>", {
        desc = "Open Netrw Explorer"
    })

    -- no more line scroll, because <C-e> is occupied by netrw
    vim.keymap.set('n', "<C-y>", "<nop>")

    -- open netrw in new tab
    vim.keymap.set('n', "<C-Space>", "<CMD>Tex<CR>:e ", {
        desc = "Open Netrw Explorer in new tab"
    })

    -- internal netrw maps
    vim.api.nvim_create_autocmd('filetype', {

        pattern = 'netrw',
        callback = function()
            -- leave
            vim.keymap.set('n', '<C-e>', '<CMD>Rex<CR>', {
                desc = 'Leave Netrw Explorer',
                buffer = true
            })

            -- go down
            vim.keymap.set('n', 'l', '<CR>', {
                desc = 'Go down in Netrw Explorer',
                remap = true,
                buffer = true
            })

            -- go up
            vim.keymap.set('n', 'h', '-', {
                desc = 'Go up in Netrw Explorer',
                remap = true,
                buffer = true
            })
        end

    })

    -- close quickfix list
    vim.keymap.set('n', "<leader>q", '<CMD>ccl<CR>', {
        desc = "Close quickfix list"
    })

    -- open quickfix list and jmp to the selected entry or close if empty
    vim.keymap.set('n', "<leader>n", '<CMD>cw<CR><CMD>cn<CR>zv', {
        desc = "Open quickfix list and jump to next entry or close if empty"
    })

    -- open quickfix list and dmp to the selected entry or close if empty
    vim.keymap.set('n', "<leader>p", '<CMD>cw<CR><CMD>cp<CR>zv', {
        desc = "Open quickfix list and jump to previous entry or close if empty"
    })

    -- open quickfix list and jump to the last selected entry or close if empty
    vim.keymap.set('n', "<leader>l", '<CMD>cw<CR><CMD>.cc<CR>zv', {
        desc = "Open quickfix list and jump to last selected entry or close if empty"
    })

    -- open git tree (supports prepending level number, i.e. 8<C-g> for 8 levels)
    vim.keymap.set('n', "<C-g>", ':<C-U>exe "GitTree ".v:count1<CR>', {
        desc = "Open Git Tree"
    })

    -- open lazy
    vim.keymap.set('n', "<leader>l", "<CMD>Lazy<CR>", {
        desc = "Open Lazy"
    })

    -- update plugins
    vim.keymap.set('n', "<leader>uu", "<CMD>Lazy update<CR>", {
        desc = "Update plugins"
    })

    -- open VSCode
    vim.keymap.set('n', "gC", "<CMD>Code<CR>", {
        desc = "Open current file in VSCode"
    })

    -- open Windsurf
    vim.keymap.set('n', "gW", "<CMD>Windsurf<CR>", {
        desc = "Open current file in Windsurf"
    })

end

