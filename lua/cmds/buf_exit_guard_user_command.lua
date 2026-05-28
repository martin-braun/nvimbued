local trm = require("utils.trm")

vim.api.nvim_create_user_command(
    'BufExitGuard',
    function(_)
        if trm.buf_any_busy() then
            vim.api.nvim_echo({
                { "Refused to exit: Busy terminal buffer!", "ErrorMsg" },
            }, true, {})
            error("running terminal job", 0)
        end
    end,
    { nargs = 0, bang = false, desc = 'Throw on busy terminal buffer (non built-ins)' }
)

