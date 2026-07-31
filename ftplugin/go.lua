local fmt = require("utils.fmt")
fmt.buf_tabify(true)
fmt.buf_fillermod(false, false, true)
fmt.buf_try_use({ "gofmt" })

