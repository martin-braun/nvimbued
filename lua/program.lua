local cmd = require("utils/cmd")

nvimbued.prgs = {
    dprint = cmd.get_resolved_invoker_of("dprint"),
    prettier = cmd.get_resolved_invoker_of("prettier"),
    shfmt = cmd.get_resolved_invoker_of("shfmt"),
    rustfmt = cmd.get_resolved_invoker_of("rustfmt"),
    gofmt = cmd.get_resolved_invoker_of("gofmt"),
    zig = cmd.get_resolved_invoker_of("zig"),
    dart = cmd.get_resolved_invoker_of("dart"),
    ktfmt = cmd.get_resolved_invoker_of("ktfmt"),
}

