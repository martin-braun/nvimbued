vim.api.nvim_create_user_command("Exec", function(opts)
    vim.cmd("r !" .. vim.env.SHELL .. " -ic " .. vim.fn.shellescape(opts.args) .. " 2>&1")
end, {
    nargs = "+",
})

