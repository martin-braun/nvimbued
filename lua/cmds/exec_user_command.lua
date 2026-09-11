vim.api.nvim_create_user_command("Exec", function(opts)
    local cursor = vim.api.nvim_win_get_cursor(0)
    local cmd = "exec 2>&1; " .. opts.args
    vim.cmd("0r !" .. vim.env.SHELL .. " -ic " .. vim.fn.shellescape(cmd) .. " 2>/dev/null")
    vim.cmd("$delete _")
    vim.api.nvim_win_set_cursor(0, cursor)
end, {
    nargs = "+",
})

