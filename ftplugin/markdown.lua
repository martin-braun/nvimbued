local fmt = require("utils.fmt")
vim.opt_local.colorcolumn = ""
vim.opt_local.wrap = true
if not fmt.buf_try_use({ "dprint", "prettier" }) then
    fmt.buf_disable_format()
end

