local wnd = require("utils.wnd")

local M = {}

M.config = function()
    -- adjusted nvim keymaps which are translated to vscode commands,
    -- for vscode keybindings which are translated to nvim commands, see
    -- .vscode/keybindings.json

    -- Rule of thumb: Simple keystrokes should be defined in
    -- .vscode/keybindings.json so they don't have to make a roundtrip to nvim,
    -- but more complex key combinations involving 3+ keystrokes should be
    -- defined in this file.
    --
    -- Some keybindings are defined in either file, because they are sub
    -- keystrokes or a richer set which is partially processed by nvim only.

    ---- from lua/keymap.lua

    local fork = wnd.get_vscode_fork()

    -- list open buffers
    vim.keymap.set(
        'n',
        "<leader>b",
        "<CMD>call VSCodeCall('workbench.files.action.focusOpenEditorsView')<CR>",
        { desc = "Navigate open tabs" }
    )

    -- create file buffer
    vim.keymap.set(
        'n',
        "<leader>c",
        "<CMD>call VSCodeCall('workbench.action.files.newUntitledFile')<CR>",
        { desc = "Create new file" }
    )
    vim.keymap.set(
        'n',
        "<leader>e",
        "<CMD>call VSCodeCall('workbench.action.quickOpen')<CR>",
        { desc = "Open file" }
    )

    -- delete buffer
    vim.keymap.set(
        'n',
        "<leader>x",
        "<CMD>call VSCodeCall('workbench.action.closeActiveEditor')<CR>",
        { desc = "Close tab" }
    )

    -- force delete buffer
    vim.keymap.set(
        'n',
        "<leader>X",
        "<CMD>call VSCodeCall('workbench.action.revertAndCloseActiveEditor')<CR>",
        { desc = "Revert changes and close tab" }
    )

    -- format buffer
    vim.keymap.set(
        'n',
        "<leader>ff",
        "<CMD>call VSCodeCall('editor.action.formatDocument')<CR>",
        { desc = "Format file" }
    )

    -- rename in buffer
    vim.keymap.set(
        'n',
        "<leader>rn",
        "<CMD>call VSCodeCall('editor.action.rename')<CR>",
        { desc = "Refactor" }
    )

    -- yank relative file path of buffer
    vim.keymap.set(
        'n',
        "<leader>yf",
        "<CMD>call VSCodeCall('copyRelativeFilePath')<CR>",
        { desc = "Copy relative file path of file" }
    )

    -- yank absolute file path of buffer
    vim.keymap.set(
        'n',
        "<leader>yF",
        "<CMD>call VSCodeCall('copyFilePath')<CR>",
        { desc = "Yank absolute file path of buffer" }
    )

    -- save all buffers and store session
    vim.keymap.set(
        'n',
        "<leader>ss",
        "<CMD>call VSCodeCall('workbench.action.files.saveAll')<CR>" ..
        "<CMD>call VSCodeCall('workbench.action.closeOtherEditors')<CR>",
        {
            desc = "Save all buffers and close hidden tabs"
        }
    )
    -- NOTE(martin-braun): workbench.action.closeOtherEditorsInAllGroups would
    -- be preferred, but it is not a thing, yet.

    -- save all buffers and quit
    vim.keymap.set(
        'n',
        "ZZ",
        "<CMD>call VSCodeCall('workbench.action.files.saveAll')<CR>" ..
        "<CMD>call VSCodeCall('workbench.action.closeWindow')<CR>",
        { desc = "Save all files and close window" }
    )

    -- quit all buffers
    vim.keymap.set(
        'n',
        "ZQ",
        "<CMD>call VSCodeCall('workbench.action.closeWindow')<CR>",
        { desc = "Close window" }
    )

    -- create tab
    vim.keymap.set(
        'n',
        "<leader>tc",
        "<CMD>call VSCodeCall('workbench.action.files.newUntitledFile')<CR>",
        { desc = "Create tab" }
    )

    -- next tab navigation
    vim.keymap.set(
        'n',
        "<leader>tn",
        "<CMD>call VSCodeCall('workbench.action.nextEditorInGroup')<CR>",
        { desc = "Next tab" }
    )
    vim.keymap.set('n',
        "<leader>n",
        "<CMD>call VSCodeCall('workbench.action.nextEditorInGroup')<CR>",
        { desc = "Next tab" }
    )
    vim.keymap.set('n',
        "<C-j>",
        "<CMD>call VSCodeCall('workbench.action.nextEditorInGroup')<CR>",
        { desc = "Next tab" }
    )

    -- previous tab navigation
    vim.keymap.set('n',
        "<leader>tp",
        "<CMD>call VSCodeCall('workbench.action.previousEditorInGroup')<CR>",
        { desc = "Previous tab" }
    )
    vim.keymap.set('n',
        "<leader>p",
        "<CMD>call VSCodeCall('workbench.action.previousEditorInGroup')<CR>",
        { desc = "Previous tab" }
    )
    vim.keymap.set('n',
        "<C-k>",
        "<CMD>call VSCodeCall('workbench.action.previousEditorInGroup')<CR>",
        { desc = "Previous tab" }
    )

    -- move tab forward
    vim.keymap.set('n',
        "<leader>j",
        "<CMD>call VSCodeCall('workbench.action.moveEditorRightInGroup')<CR>",
        { desc = "Move tab forward" }
    )

    -- move tab backward
    vim.keymap.set('n',
        "<leader>k",
        "<CMD>call VSCodeCall('workbench.action.moveEditorLeftInGroup')<CR>",
        { desc = "Move tab backward" }
    )

    -- close other tabs
    vim.keymap.set(
        'n',
        "<leader>to",
        "<CMD>call VSCodeCall('workbench.action.closeOtherEditors')<CR>",
        { desc = "Close other tabs" }
    )

    -- create terminal tab
    vim.keymap.set(
        'n',
        "<leader>tt",
        "<CMD>call VSCodeCall('workbench.action.createTerminalEditor')<CR>",
        { desc = "Create terminal buffer" }
    )
    vim.keymap.set(
        'n',
        "<leader>ts",
        "<CMD>call VSCodeCall('workbench.action.terminal.newInActiveWorkspace')<CR>",
        { desc = "Create terminal buffer after horizontal split" }
    )
    vim.keymap.set('n',
        "<leader>tv",
        "<CMD>call VSCodeCall('workbench.action.createTerminalEditorSide')<CR>",
        { desc = "Create terminal buffer after vertical split" }
    )

    ---- from lua/maps/telescope_maps.lua

    -- find files
    vim.keymap.set(
        'n',
        "<leader>E",
        "<CMD>call VSCodeCall('workbench.action.quickOpenWithModes')<CR>",
        { desc = "Find files with modes" }
    )
    vim.keymap.set(
        'n',
        "<leader><leader>e",
        "<CMD>call VSCodeCall('workbench.action.quickOpenWithModes')<CR>",
        { desc = "Find files with modes" }
    )
    vim.keymap.set(
        'n',
        "<leader><C-Space>",
        "<CMD>call VSCodeCall('workbench.action.quickOpenWithModes')<CR>",
        { desc = "Find files with modes" }
    )

    -- search keymaps
    vim.keymap.set(
        'n',
        "<C-c>",
        "<CMD>nohlsearch<CR>", {
            desc = "Clear find highlights", silent = true
        }
    )
    vim.keymap.set(
        'n',
        "<leader>fk",
        "<CMD>call VSCodeCall('workbench.action.openGlobalKeybindings')<CR>",
        { desc = "Show keyboard shortcuts" }
    )

    -- git
    vim.keymap.set(
        'n',
        "<leader>g",
        "<CMD>call VSCodeCall('workbench.scm.focus')<CR>",
        { desc = "Show Git Status" }
    )

    ---- VSCode exclusives

    -- quickfix
    vim.keymap.set(
        'n',
        "<leader>fl",
        "<CMD>call VSCodeCall('editor.action.quickFix')<CR>",
        { desc = "Quick Fix..." }
    )

    -- windsurf extension
    vim.keymap.set(
        'i',
        "<C-f>",
        "<CMD>call VSCodeCall('codeium.showNextCompletion')<CR>",
        { desc = "Show Next Completion" }
    )
    vim.keymap.set(
        'i',
        "<C-b>",
        "<CMD>call VSCodeCall('codeium.showPreviousCompletion')<CR>",
        { desc = "Show Previous Completion" }
    )

    if fork == "windsurf" then
        ---- Windsurf IDE exclusives
        vim.keymap.set(
            'n',
            "<leader>l",
            "<CMD>call VSCodeCall('windsurf.triggerCascade')<CR>",
            { desc = "Prompt Cascade" }
        )
        vim.keymap.set(
            'n',
            "<leader>i",
            "<CMD>call VSCodeCall('windsurf.prioritized.command.open')<CR>",
            { desc = "Editor Inline Chat" }
        )
    elseif fork == "code" then
        ---- Microsoft VSCode IDE exclusives
        vim.keymap.set(
            'n',
            "<leader>l",
            "<CMD>call VSCodeCall('workbench.panel.chat')<CR>",
            { desc = "Prompt Copilot" }
        )
    end

    ---- VSCode extensions

    -- PlatformIO
    vim.keymap.set(
        'n',
        "<leader>p",
        "<CMD>call VSCodeCall('workbench.view.extension.platformio')<CR>",
        { desc = "Show PlatformIO" }
    )

end

return M

