local fmt = require("utils.fmt")
vim.opt_local.colorcolumn = ""
vim.opt_local.wrap = true
fmt.buf_fillermod(false, false, false)
fmt.buf_disable_format()

