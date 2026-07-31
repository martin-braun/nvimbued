local M = { "EdenEast/nightfox.nvim" }
M.main = "nightfox"
M.cond = true

M.lazy = false

M.opts = {}

M.config = function()
    local nightfox = require(M.main)
    local Shade = require(M.main .. ".lib.shade")
    local conf = require(M.main .. ".config")
    --
    -- TONSKY INSPIRED SYNTAX FIXES COMMON
    --
    local stl = conf.options.styles
    stl.builtin = "bold"
    stl.comments = "bold"
    stl.conditionals = "bold"
    stl.constants = "NONE"
    stl.functions = "NONE"
    stl.keywords = "bold"
    stl.numbers = "NONE"
    stl.operators = "NONE"
    stl.preprocs = "bold"
    stl.strings = "NONE"
    stl.types = "bold"
    stl.variables = "NONE"
    --
    -- TONSKY INSPIRED SYNTAX FIXES DARK
    --
    local darkpal = require(M.main .. ".palette").load("carbonfox")
    darkpal.black = Shade.new("#191b24", 0.35, -0.35)
    darkpal.blue = Shade.new("#9db9f4", 0.35, -0.35)
    darkpal.cyan = Shade.new("#63cdcf", 0.35, -0.35)
    darkpal.green = Shade.new("#8cc470", 0.35, -0.35)
    darkpal.magenta = Shade.new("#9d79d6", 0.35, -0.35)
    darkpal.orange = Shade.new("#f4a261", 0.35, -0.35)
    darkpal.pink = Shade.new("#d67ad2", 0.35, -0.35)
    darkpal.red = Shade.new("#f06372", 0.35, -0.35)
    darkpal.transparent = "#1a1f28" -- TODO: Change to `NONE` after https://github.com/neovim/neovim/issues/37874 has been fixed.
    darkpal.white = Shade.new("#dfdfe0", 0.35, -0.35)
    darkpal.yellow = Shade.new("#edc57d", 0.35, -0.35)
    --
    darkpal.comment = darkpal.yellow.base
    local darkspec = darkpal:generate_spec()
    darkspec.palette = darkpal
    --
    local darksyn = darkspec.syntax
    darksyn.bracket = darkpal.black.bright -- Brackets
    darksyn.builtin0 = darksyn.variable -- Builtin variable
    darksyn.builtin1 = darksyn.variable -- Builtin type
    darksyn.conditional = darksyn.variable -- Conditional and loop
    darksyn.const = darksyn.variable -- Constants and imports
    darksyn.field = darksyn.variable -- Field
    darksyn.func = darkpal.blue.base -- Functions and Titles
    darksyn.ident = darksyn.variable -- Identifiers
    darksyn.keyword = darksyn.variable -- Keywords
    darksyn.number = darkpal.red.base -- Numbers
    darksyn.regex = darkpal.pink.base -- Regex
    darksyn.type = darksyn.variable -- Types
    --
    local darkdiag = darkspec.diag
    darkdiag.error = darkpal.red.base
    darkdiag.hint = darkpal.cyan.base
    darkdiag.info = darkpal.blue.base
    darkdiag.warn = darkpal.orange.base
    --
    local darktheme = vim.tbl_deep_extend(
        "error",
        require(M.main .. ".group.syntax").get(darkspec, conf.options),
        require(M.main .. ".group.modules.treesitter").get(darkspec, conf.options)
    )
    darktheme.CursorLineNr = { fg = darkpal.bg3, bg = darkpal.fg3, style = "bold" } -- Like LineNr when 'cursorline' or 'relativenumber' is set for the cursor line.
    darktheme.Function = { fg = darksyn.variable, style = stl.functions } -- function name (also: methods for classes)
    darktheme.IncSearch = { fg = darkpal.black.dim, bg = darkpal.cyan.bright }
    darktheme.Search = { fg = darkspec.fg0, bg = darkpal.black.bright }
    darktheme.PreProc = { fg = darkspec.fg0, style = stl.preprocs } -- (preferred) generic Preprocessor
    darktheme.Special = { fg = darkpal.builtin0, style = stl.builtin } -- (preferred) any special symbol
    darktheme.Title = { fg = darkspec.fg0, style = "bold" }
    darktheme.Visual = { fg = darkpal.bg2, bg = darkpal.fg2 } -- selection
    darktheme["@constant.builtin"] = { fg = darkpal.orange.dim, style = stl.builtin } -- built-in constant values
    darktheme["@constructor"] = { fg = darksyn.ident, style = stl.types }
    darktheme["@constructor.lua"] = { link = "@punctuation.bracket" } -- Lua's constructor is { }
    darktheme["@function"] = { fg = darksyn.func, style = stl.functions } -- function definitions
    darktheme["@function.builtin"] = { fg = darksyn.builtin0, style = stl.builtin } -- built-in functions
    darktheme["@function.macro"] = { fg = darksyn.builtin0, style = stl.builtin } -- preprocessor macros
    darktheme["@keyword.return"] = { fg = darksyn.builtin0, style = stl.builtin } -- keywords like `return` and `yield`
    darktheme["@label.json"] = { fg=darkpal.white } -- For labels: label: in C and :label: in Lua.
    darktheme["@markup.math"] = { fg=darksyn.number } -- math environments (e.g. `$ ... $` in LaTeX)
    darktheme["@markup.raw.block"] = { fg = darkspec.fg1 }
    darktheme["@markup.raw.markdown_inline"] = { fg = darkpal.red.base, style = "bold" }
    darktheme["@module"] = { fg = darksyn.builtin1, stl.builtin } -- modules or namespaces
    darktheme["@punctuation.bracket"] = { fg = darkpal.white, bg = darksyn.bracket } -- brackets (e.g. `()` / `{}˚ / `[]`)
    darktheme["@punctuation.delimiter"] = { fg = darksyn.variable } -- delimiters (e.g. `;` / `.` / `,`)
    darktheme["@tag.attribute"] = { fg=darksyn.variable, style = "italic" } -- XML-style tag attributes
    darktheme["@type.builtin"] = { fg = darksyn.builtin1, style = stl.builtin } -- built-in types
    darktheme["@variable.builtin"] = { fg = darksyn.builtin0, style = stl.builtin } -- built-in variable names (e.g. `this`)
    darktheme["@variable.member.yaml"] = { fg=darksyn.variable } -- For fields.
    --
    -- TONSKY INSPIRED SYNTAX FIXES LIGHT
    --
    local lightpal = require(M.main .. ".palette").load("dayfox")
    lightpal.black = Shade.new("#191b24", 0.35, -0.35)
    lightpal.blue = Shade.new("#9db9f4", 0.35, -0.35)
    lightpal.cyan = Shade.new("#63cdcf", 0.35, -0.35)
    lightpal.green = Shade.new("#8cc470", 0.35, -0.35)
    lightpal.magenta = Shade.new("#9d79d6", 0.30, -0.35)
    lightpal.orange = Shade.new("#f4a261", 0.35, -0.35)
    lightpal.pink = Shade.new("#d67ad2", 0.35, -0.35)
    lightpal.red = Shade.new("#f06372", 0.35, -0.35)
    lightpal.transparent = "#fffff0" -- TODO: Change to `NONE` after https://github.com/neovim/neovim/issues/37874 has been fixed.
    lightpal.white = Shade.new("#dfdfe0", 0.35, -0.35)
    lightpal.yellow = Shade.new("#edc57d", 0.35, -0.35)
    --
    lightpal.comment = lightpal.yellow.bright
    local lightspec = lightpal:generate_spec()
    lightspec.palette = lightpal
    --
    local lightsyn = lightspec.syntax
    -- lightsyn.builtin2 = lightpal.orange.bright -- Builtin const
    -- lightsyn.builtin3 = pad.red.bright -- Not used
    -- lightsyn.comment = lightpal.comment -- Comment
    -- lightsyn.dep = spec.fg3 -- Deprecated
    -- lightsyn.operator = spec.fg2 -- Operators
    -- lightsyn.preproc = lightpal.pink.bright -- PreProc
    -- lightsyn.variable = lightpal.black.base -- Variables
    lightsyn.bracket = lightpal.black.bright -- Brackets
    lightsyn.builtin0 = lightsyn.variable -- Builtin variable
    lightsyn.builtin1 = lightsyn.variable -- Builtin type
    lightsyn.conditional = lightsyn.variable -- Conditional and loop
    lightsyn.const = lightsyn.variable -- Constants and imports
    lightsyn.field = lightsyn.variable -- Field
    lightsyn.func = lightpal.blue.bright -- Functions and Titles
    lightsyn.ident = lightsyn.variable -- Identifiers
    lightsyn.keyword = lightsyn.variable -- Keywords
    lightsyn.number = lightpal.red.bright -- Numbers
    lightsyn.regex = lightpal.pink.bright -- Regex
    lightsyn.statement = lightpal.magenta.bright -- Statements
    lightsyn.string = lightpal.green.bright -- Strings --- FIXME: @variable.member.lua's style is set to 'NONE', but "string" is still bold
    lightsyn.type = lightsyn.variable -- Types
    --
    local lightdiag = lightspec.diag
    lightdiag.error = lightpal.red.dim
    lightdiag.hint = lightpal.cyan.dim
    lightdiag.info = lightpal.blue.dim
    lightdiag.warn = lightpal.orange.dim
    --
    local lighttheme = vim.tbl_deep_extend(
        "error",
        require(M.main .. ".group.syntax").get(lightspec, conf.options),
        require(M.main .. ".group.modules.treesitter").get(lightspec, conf.options)
    )
    -- lighttheme.Bold = { style = "bold" }
    -- lighttheme.Boolean = { link = "Number" } -- a boolean constant: TRUE, false
    -- lighttheme.Debug = { link = "Special" } -- debugging statements
    -- lighttheme.Define = { link = "PreProc" } -- preprocessor #define
    -- lighttheme.Delimiter = { link = "Special" } -- character that needs attention
    -- lighttheme.Error = { fg = spec.diag.error } -- (preferred) any erroneous construct
    -- lighttheme.Exception = { link = "Keyword" } -- try, catch, throw
    -- lighttheme.Float = { link = "Number" } -- a floating point constant: 2.3e10
    -- lighttheme.Identifier = { fg = lightsyn.ident, style = stl.variables } -- (preferred) any variable name
    -- lighttheme.Include = { link = "PreProc" } -- preprocessor #include
    -- lighttheme.Italic = { style = "italic" }
    -- lighttheme.Label = { link = "Conditional" } -- case, default, etc.
    -- lighttheme.Macro = { link = "PreProc" } -- same as Define
    -- lighttheme.PreCondit = { link = "PreProc" } -- preprocessor #if, #else, #endif, etc.
    -- lighttheme.Repeat = { link = "Conditional" } -- for, do, while, etc.
    -- lighttheme.SpecialChar = { link = "Special" } -- special character in a constant
    -- lighttheme.SpecialComment = { link = "Special" } -- special things inside a comment
    -- lighttheme.Statement = { fg = lightsyn.keyword, style = stl.keywords } -- (preferred) any statement
    -- lighttheme.StorageClass = { link = "Type" } -- static, register, volatile, etc.
    -- lighttheme.Structure = { link = "Type" } -- struct, union, enum, etc.
    -- lighttheme.Tag = { link = "Special" } -- you can use CTRL-] on this
    -- lighttheme.Todo = { fg = spec.bg1, bg = spec.diag.info } -- (preferred) anything that needs extra attention; mostly the keywords TODO FIXME and XXX
    -- lighttheme.Typedef = { link = "Type" } -- A typedef
    -- lighttheme.Underlined = { style = "underline" } -- (preferred) text that stands out, HTML links
    -- lighttheme.qfFileName = { link = "Directory" }
    -- lighttheme.qfLineNr = { link = "lineNr" }
    -- lighttheme["@attribute"] = { link = "Constant" } -- attribute annotations (e.g. Python decorators)
    -- lighttheme["@boolean"] = { link = "Boolean" } -- boolean literals
    -- lighttheme["@character"] = { link = "Character" } -- character literals
    -- lighttheme["@character.special"] = { link = "SpecialChar" } -- special characters (e.g. wildcards)
    -- lighttheme["@comment"] = { link = "Comment" } -- line and block comments
    -- lighttheme["@comment.error"] = { fg = spec.bg1, bg = spec.diag.error } -- error-type comments (e.g. `ERROR`, `FIXME`, `DEPRECATED:`)
    -- lighttheme["@comment.note"] = { fg = spec.bg1, bg = spec.diag.info } -- note-type comments (e.g. `NOTE:`, `INFO:`, `XXX`)
    -- lighttheme["@comment.todo"] = { fg = spec.bg1, bg = spec.diag.hint } -- todo-type comments (e.g. `TODO:`, `WIP:`, `FIXME:`)
    -- lighttheme["@comment.warning"] = { fg = spec.bg1, bg = spec.diag.warn } -- warning-type comments (e.g. `WARNING:`, `FIX:`, `HACK:`)
    -- lighttheme["@constant"] = { link = "Constant" } -- constant identifiers
    -- lighttheme["@constant.macro"] = { link = "Macro" } -- constants defined by the preprocessor
    -- lighttheme["@diff.delta"] = { link = "diffChanged" } -- changed text (for diff files)
    -- lighttheme["@diff.minus"] = { link = "diffRemoved" } -- deleted text (for diff files)
    -- lighttheme["@diff.plus"] = { link = "diffAdded" } -- added text (for diff files)
    -- lighttheme["@field.rust"] = { fg = spec.fg2 }
    -- lighttheme["@keyword"] = { link = "Keyword" } -- keywords not fitting into specific categories
    -- lighttheme["@keyword.conditional"] = { link = "Conditional" } -- keywords related to conditionals (e.g. `if` / `else`)
    -- lighttheme["@keyword.conditional.ternary"] = { link = "Conditional" } -- ternary operator (e.g. `?` / `:`)
    -- lighttheme["@keyword.exception"] = { link = "Exception" } -- keywords related to exceptions (e.g. `throw` / `catch`)
    -- lighttheme["@keyword.function"] = { fg = lightsyn.keyword, style = stl.functions } -- keywords that define a function (e.g. `func` in Go, `def` in Python)
    -- lighttheme["@keyword.import"] = { link = "Include" } -- keywords for including modules (e.g. `import` / `from` in Python)
    -- lighttheme["@keyword.operator"] = { fg = lightsyn.operator, style = stl.operators } -- operators that are English words (e.g. `and` / `or`)
    -- lighttheme["@keyword.repeat"] = { link = "Repeat" } -- keywords related to loops (e.g. `for` / `while`)
    -- lighttheme["@keyword.storage"] = { link = "StorageClass" } -- modifiers that affect storage in memory or life-time
    -- lighttheme["@label"] = { link = "Label" } -- GOTO and other labels (e.g. `label:` in C), including heredoc labels
    -- lighttheme["@markup"] = { fg = spec.fg1 } -- For strings considerated text in a markup language.
    -- lighttheme["@markup.heading"] = { link = "Title" } -- headings, titles (including markers)
    -- lighttheme["@markup.italic"] = { link = "Italic" } -- italic text
    -- lighttheme["@markup.link"] = { fg = lightsyn.keyword, style = "bold" } -- text references, footnotes, citations, etc.
    -- lighttheme["@markup.link.label"] = { link = "Special" } -- link, reference descriptions
    -- lighttheme["@markup.link.url"] = { fg = lightsyn.const, style = "italic,underline" } -- URL-style links
    -- lighttheme["@markup.list"] = { fg = lightsyn.builtin1, style = stl.operators } -- list markers
    -- lighttheme["@markup.list.checked"] = { fg = P.green.base } -- checked todo-style list markers
    -- lighttheme["@markup.list.unchecked"] = { fg = P.yellow.base } -- unchecked todo-style list markers
    -- lighttheme["@markup.quote"] = { fg = spec.fg2 } -- block quotes
    -- lighttheme["@markup.raw"] = { fg = lightsyn.ident, style = "italic" } -- literal or verbatim text (e.g. inline code)
    -- lighttheme["@markup.raw.block"] = { fg = P.pink.base } -- literal or verbatim text as a stand-alone block (use priority 90 for blocks with injections)
    -- lighttheme["@markup.strikethrough"] = { fg = spec.fg1, style = "strikethrough" } -- struck-through text
    -- lighttheme["@markup.underline"] = { link = "Underline" } -- underlined text (only for literal underline markup!)
    -- lighttheme["@number"] = { link = "Number" } -- numeric literals
    -- lighttheme["@number.float"] = { link = "Float" } -- floating-point number literals
    -- lighttheme["@operator"] = { link = "Operator" } -- symbolic operators (e.g. `+` / `*`)
    -- lighttheme["@string"] = { link = "String" } -- string literals
    -- lighttheme["@string.special"] = { link = "Special" } -- other special strings (e.g. dates)
    -- lighttheme["@string.special.url"] = { fg = lightsyn.const, style = "italic,underline" } -- URIs (e.g. hyperlinks)
    -- lighttheme["@tag"] = { fg = lightsyn.keyword } -- XML-style tag names (and similar)
    -- lighttheme["@tag.delimiter"] = { fg = lightsyn.builtin1 } -- XML-style tag delimiters
    -- lighttheme["@type"] = { link = "Type" } -- type or class definitions and annotations
    lighttheme.Comment = { fg = lightspec.fg0, bg = lightsyn.comment, style = stl.comments } -- any comment
    lighttheme.Conditional = { fg = lightspec.fg0, style = stl.conditionals } -- if, then, else, endif, switch, etc.
    lighttheme.CursorLineNr = { fg = lightspec.fg2, bg = lightspec.bg2, style = "bold" } -- Like LineNr when 'cursorline' or 'relativenumber' is set for the cursor line.
    lighttheme.Function = { fg = lightsyn.variable, style = stl.functions } -- function name (also: methods for classes)
    lighttheme.IncSearch = { fg = lightspec.fg0, bg = lightpal.cyan.bright }
    lighttheme.Search = { fg = lightspec.fg0, bg = lightpal.white.base }
    lighttheme.Keyword = { fg = lightspec.fg0, style = stl.keywords } -- any other keyword
    lighttheme.Number = { fg = lightspec.fg0, bg = lightsyn.number, style = stl.numbers } -- a number constant: 234, 0xff
    lighttheme.Operator = { fg = lightspec.fg0, style = stl.operators } -- "sizeof", "+", "*", etc.
    lighttheme.PreProc = { fg = lightspec.fg0, style = stl.preprocs } -- (preferred) generic Preprocessor
    lighttheme.Special = { fg=lightsyn.builtin0, style = stl.builtin } -- (preferred) any special symbol
    lighttheme.String = { fg = lightspec.fg0, bg = lightsyn.string, style = stl.strings, nocombine = 'false' } -- a string constant: "this is a string"
    lighttheme.Title = { fg = lightspec.fg0, style = "bold" }
    lighttheme.Type = { fg = lightsyn.type, bg = lightpal.transparent, style = stl.types } -- (preferred) int, long, char, etc.
    lighttheme.Visual = { fg = lightspec.bg2, bg = lightspec.fg2 } -- selection
    lighttheme.typescriptParens = { fg = lightpal.white, bg = lightsyn.bracket } -- For typescript
    lighttheme["@constant.builtin"] = { fg = lightpal.orange.dim, style = stl.builtin } -- built-in constant values
    lighttheme["@constructor"] = { fg = lightsyn.ident, bg = lightpal.transparent, style = stl.types }
    lighttheme["@constructor.lua"] = { link = "@punctuation.bracket" } -- Lua's constructor is { }
    lighttheme["@function"] = { fg = lightspec.fg0, bg = lightsyn.func, style = stl.functions } -- function definitions
    lighttheme["@function.builtin"] = { fg = lightspec.fg0, style = stl.builtin } -- built-in functions
    lighttheme["@function.call.bash"] = { lightspec.fg0, bg =lightpal.transparent, style = stl.functions }
    lighttheme["@function.macro"] = { fg = lightspec.fg0, style = stl.builtin } -- preprocessor macros
    lighttheme["@function.method.call.solidity"] = { lightspec.fg0, bg =lightpal.transparent, style = stl.functions }
    lighttheme["@keyword.return"] = { fg = lightspec.fg0, style = stl.builtin } -- keywords like `return` and `yield`
    lighttheme["@label.json"] = { fg=lightspec.fg0 } -- For labels: label: in C and :label: in Lua.
    lighttheme["@markup.math"] = { fg=lightspec.fg0, bg=lightsyn.number } -- math environments (e.g. `$ ... $` in LaTeX)
    lighttheme["@markup.raw.block"] = { fg = lightspec.fg1 }
    lighttheme["@markup.raw.markdown_inline"] = { fg = lightpal.red.dim, style = "bold" }
    lighttheme["@module"] = { fg = lightspec.fg0, stl.builtin } -- modules or namespaces
    lighttheme["@property"] = { fg = lightspec.fg0 } -- the key in key/value pairs
    lighttheme["@property.yaml"] = { fg = lightspec.fg0, bg = lightpal.transparent }
    lighttheme["@punctuation.bracket"] = { fg = lightpal.white, bg = lightsyn.bracket } -- brackets (e.g. `()` / `{}˚ / `[]`)
    lighttheme["@punctuation.delimiter"] = { fg = lightpal.black } -- delimiters (e.g. `;` / `.` / `,`)
    lighttheme["@punctuation.special.bash"] = { fg = lightsyn.builtin0, bg = lightpal.transparent, style = stl.builtin } -- special symbols (e.g. `{}` in string interpolation)
    lighttheme["@string.escape"] = { fg = lightspec.fg0, bg = lightsyn.regex, style = "bold" } -- escape sequences
    lighttheme["@string.regexp"] = { fg = lightspec.fg0, bg = lightsyn.regex, style = stl.strings } -- regular expressions
    lighttheme["@tag.attribute"] = { fg=lightsyn.variable, style = "italic" } -- XML-style tag attributes
    lighttheme["@type.builtin"] = { fg = lightspec.fg0, bg = lightpal.transparent, style = stl.builtin } -- built-in types
    lighttheme["@variable.bash"] = { fg = lightsyn.variable, bg = lightpal.transparent, style = stl.variables } -- various variable names
    lighttheme["@variable.builtin"] = { fg = lightspec.fg0, style = stl.builtin } -- built-in variable names (e.g. `this`)
    lighttheme["@variable.member"] = { fg = lightspec.fg0, style = stl.variables } -- object and struct fields
    lighttheme["@variable.member.lua"] = { fg = lightspec.fg0, style = stl.variables }
    lighttheme["@variable.member.yaml"] = { fg = lightsyn.variable } -- For fields.
    lighttheme["@variable.parameter"] = { fg = lightspec.fg0, style = stl.variables } -- parameters of a function
    lighttheme["@variable.parameter.bash"] = { fg = lightspec.fg0, bg = lightpal.transparent, style = stl.variables } -- parameters of a function
    -- lighttheme["@type.builtin.go"] = { fg = lightspec.fg0, bg = lightpal.transparent, style = stl.types } -- parameters of a function
    --
    -- [!] You can use `:Inspect` to identify treesitter groups and solve issues.
    --
    local commontheme = {}
    commontheme.CursorLine = { bg = "NONE" } -- Screen-line at the cursor, when 'cursorline' is set.  Low-priority if foreground (ctermfg OR guifg) is not set.
    commontheme.Whitespace = { fg = "#FF0000" } -- ghost chars
    commontheme["@function.call"] = { link = "Function" }
    commontheme["@function.make"] = { link = "Function" }
    commontheme["@function.method.call.go"] = { link = "Function" }
    commontheme["@function.method.call.lua"] = { link = "Function" }
    commontheme["@function.method.call.python"] = { link = "Function" }
    commontheme["@function.method.call.java"] = { link = "Function" }
    commontheme["@markup.strong"] = { link = "Bold" }
    commontheme["@punctuation.special"] = { link = "Special" } -- special symbols (e.g. `{}` in string interpolation)
    --
    nightfox.setup({
        options = {
            transparent = true,
            styles = stl
        },
        palettes = {
            carbonfox = darkpal,
            dayfox = lightpal
        },
        groups = {
            carbonfox = vim.tbl_deep_extend(
                "error",
                commontheme,
                darktheme
            ),
            dayfox = vim.tbl_deep_extend(
                "error",
                commontheme,
                lighttheme
            )
        }
    })
    -- -- bracket matching highlights
    -- vim.cmd([[hi MatchParen guifg=#ffffff]])
end

return M

