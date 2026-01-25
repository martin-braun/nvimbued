local fmt = require("utils.fmt")
fmt.buf_tabify(true)
fmt.buf_fillermod(false, false)
fmt.buf_try_use({ "gofmt" })

