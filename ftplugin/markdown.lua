local fmt = require("utils.fmt")
vim.opt_local.colorcolumn = ""
vim.opt_local.wrap = true
fmt.buf_fillermod(false, false, false)
if not fmt.buf_try_use({ "dprint", "prettier" }) then
    fmt.buf_disable_format()
end

