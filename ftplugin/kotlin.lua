local fmt = require("utils.fmt")
vim.opt_local.colorcolumn = "101" -- aligned with Android Studio
fmt.buf_try_use({ "ktfmt" })

