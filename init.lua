nvimbued = {} -- global custom state for this configuration
require("common") -- basic behavior
require("buffer") -- buffer behavior
require("control") -- control behavior
require("netrw") -- netrw behavior
require("program") -- registering program dependencies
require("format") -- formatting (depends on programs)
require("keymap") -- base non-plugin specific keymaps
require("plugin") -- lazy.nvim plugin manager (loads specs and plugin maps)
require("provs") -- providers (ignored for non terminal window modes)
require("cmds") -- load user commands
require("ide") -- compatibility layer for vscode/vscodium/windsurf
