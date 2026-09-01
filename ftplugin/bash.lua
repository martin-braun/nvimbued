local fmt = require("utils.fmt")
if not fmt.buf_try_use({ "shfmt" }) then
    fmt.buf_disable_format()
end

