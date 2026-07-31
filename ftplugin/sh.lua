local fmt = require("utils.fmt")
fmt.buf_tabify()
if not fmt.buf_try_use({ "shfmt" }) then
    fmt.buf_disable_format()
end

