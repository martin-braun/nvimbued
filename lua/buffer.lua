-- line numbers
vim.wo.number = true
vim.wo.relativenumber = true

-- scroll behavior
vim.opt.scrolloff = 3
vim.opt.sidescrolloff = 8

-- ghost chars
vim.opt.list = true
vim.opt.listchars = {
    space = ' ',
    tab = '➾ ',
    multispace = '·',
    lead = ' ',
    trail = '•',
    nbsp = '⋯'
}
vim.opt.linebreak = true
vim.opt.showbreak = '↪︎ '

-- cursor
vim.opt.cursorline = true

-- undercurl
vim.cmd([[let &t_Cs = "\e[4:3m"]])
vim.cmd([[let &t_Ce = "\e[4:0m"]])

-- filetype definitions
vim.api.nvim_create_autocmd({ 'BufReadPre' }, {
    callback = function()
        vim.filetype.add({
            extension = {
                arb = "json",
                bru = "json",
                ["code-snippets"] = "json",
                ["code-workspace"] = "json",
                dockerignore = "gitignore",
                rsyncignore = "gitignore",
                fvmrc = "json",
                log = "log",
                plist = "xml",
                rc = "sh",
                reg = "dosini",
                stignore = "gitignore",
                xaml = "xml",
            },
            filename = {
                ["playbook.yml"] = "yaml.ansible",
                ["requirements.yml"] = "yaml.ansible",
            },
            pattern = {
                ["%.env%..*"] = "sh",
                [".*/ansible/.*%.ya?ml"] = "yaml.ansible",
                -- firenvim filetypes for common domains:
                ["github.com_*.txt"] = "markdown",
                ["stackoverflow.com_*.txt"] = "markdown",
                ["superuser.com_*.txt"] = "markdown",
                ["*.stackexchange.com_*.txt"] = "markdown",
            },
        })
    end,
})

-- trigger ftplugins on BufEnter as well
vim.api.nvim_create_autocmd("BufEnter", {
  callback = function()
    vim.cmd("doautocmd <nomodeline> FileType")
  end,
})

