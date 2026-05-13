local sys = require("utils.sys")
local wnd = require("utils.wnd")
local M = {}

local get_dprint_prgcall = function()
    if nvimbued.configured_formatters ~= nil and
        vim.tbl_contains(nvimbued.configured_formatters, "dprint") then
        return nvimbued.prgs.dprint .. ' fmt' ..
            ' --stdin ' .. '"' ..
            vim.fn.fnameescape(vim.api.nvim_buf_get_name(0)) .. '"'
    end
    -- as fallback we use a local config in this vim configuration (nvim only):
    return nvimbued.prgs.dprint .. ' fmt' ..
        ' --stdin ' ..
        '"' .. vim.fn.fnameescape(vim.api.nvim_buf_get_name(0)) .. '"' ..
        ' -c ' ..
        '"' ..
        vim.fn.stdpath('config') .. package.config:sub(1, 1) ..
        "dprint.json" ..
        '"'
end

local get_prettier_prgcall = function()
    if nvimbued.configured_formatters ~= nil and
        vim.tbl_contains(nvimbued.configured_formatters, "prettier") then
        return nvimbued.prgs.prettier ..
            ' --stdin-filepath ' .. '"' ..
            vim.fn.fnameescape(vim.api.nvim_buf_get_name(0)) ..
            '"'
    end
    -- as fallback we use a local config in this vim configuration (nvim only):
    return nvimbued.prgs.prettier ..
        ' --stdin-filepath ' ..
        '"' .. vim.fn.fnameescape(vim.api.nvim_buf_get_name(0)) .. '"' ..
        ' --config ' ..
        '"' ..
        vim.fn.stdpath('config') .. package.config:sub(1, 1) ..
        "prettier.config.js" ..
        '"'
end

local get_shfmt_prgcall = function()
    return nvimbued.prgs.shfmt ..
        ' --indent 0 -bn -ci -sr' ..
        ' --filename ' ..
        '"' .. vim.fn.fnameescape(vim.api.nvim_buf_get_name(0)) .. '"'
end

local get_rustfmt_prgcall = function()
    if nvimbued.configured_formatters ~= nil and
        vim.tbl_contains(nvimbued.configured_formatters, "rustfmt") then
        return nvimbued.prgs.rustfmt
    end
    -- as fallback we use a local config in this vim configuration (nvim only):
    return nvimbued.prgs.rustfmt ..
        ' --config-path ' ..
        '"' ..
        vim.fn.stdpath('config') .. package.config:sub(1, 1) ..
        "rustfmt.toml" ..
        '"'
end

local get_gofmt_prgcall = function()
    return nvimbued.prgs.gofmt
end

local get_zig_prgcall = function()
    return nvimbued.prgs.zig .. " fmt --stdin"
end

local get_dart_prgcall = function()
    if nvimbued.configured_formatters ~= nil and
        vim.tbl_contains(nvimbued.configured_formatters, "dart") then
        return nvimbued.prgs.dart .. ' format' ..
            ' --stdin-name ' ..
            '"' .. vim.fn.fnameescape(vim.api.nvim_buf_get_name(0)) .. '"' ..
            ' -o show'
    end
    return nvimbued.prgs.dart .. ' format' ..
        ' --stdin-name ' ..
        '"' .. vim.fn.fnameescape(vim.api.nvim_buf_get_name(0)) .. '"' ..
        ' -o show' ..
        ' --page-width 80 --indent 0'
end

local get_ktfmt_prgcall = function()
    return nvimbued.prgs.ktfmt .. ' --kotlinlang-style --enable-editorconfig' ..
        ' --stdin-name=' ..
        '"' .. vim.fn.fnameescape(vim.api.nvim_buf_get_name(0)) .. '"' ..
        ' -' -- stdin mode
end

M.buf_try_use = function(formatters, configured_only)
    if not wnd.is_terminal() then
        -- IDEs have their own plugins and extensions to format code,
        -- so give a false positive, indicating that formatting worked.
        return true
    end
    local tmp_fmt = vim.fn.stdpath('config') .. '/.tmp/.fmt'
    -- pre command:
    local pre = not sys.is_windows()
    and 'tee "' .. tmp_fmt .. '" | '
    or 'FIND /v "" > "' .. tmp_fmt .. '" && '
    -- post command:
    local post = not sys.is_windows()
    and ' 2>/dev/null || cat "' .. tmp_fmt .. '"'
    or ' 2>NUL < "' .. tmp_fmt .. '" || TYPE "' .. tmp_fmt .. '"'
    -- post = '' -- for debugging
    if formatters == nil then
        return false
    end
    if type(formatters) ~= "table" then
        formatters = { formatters }
    end
    formatters_to_use = {}
    -- select any locally configured and selected formatters first such as a
    -- local dprint.json or prettier.config js, this is always nil on browsers
    -- (see ./lua/format.lua), since we aren't in any project with format
    -- configuration files
    if nvimbued.configured_formatters ~= nil then
        for _, formatter in ipairs(formatters) do
            if vim.tbl_contains(nvimbued.configured_formatters, formatter) then
                table.insert(formatters_to_use, formatter)
            end
        end
    end
    -- if not wanted, append all requested formatters anyways, otherwise skip to
    -- only use the given formatters when a local config is available, such as
    -- dprint.json or prettier.config.js
    if not configured_only then
        for _, formatter in ipairs(formatters) do
            table.insert(formatters_to_use, formatter)
        end
    end
    -- apply first formatter to use to equalprg/formatprg, if its available
    for _, formatter in ipairs(formatters_to_use) do
        if formatter == "dprint" and nvimbued.prgs.dprint then
            vim.opt_local.equalprg = pre .. get_dprint_prgcall() .. post
            vim.opt_local.formatprg = pre .. get_dprint_prgcall() .. post
            return true
        elseif formatter == "prettier" and nvimbued.prgs.prettier then
            vim.opt_local.equalprg = pre .. get_prettier_prgcall() .. post
            vim.opt_local.formatprg = pre .. get_prettier_prgcall() .. post
            return true
        elseif formatter == "shfmt" and nvimbued.prgs.shfmt then
            vim.opt_local.equalprg = pre .. get_shfmt_prgcall() .. post
            vim.opt_local.formatprg = pre .. get_shfmt_prgcall() .. post
            return true
        elseif formatter == "rustfmt" and nvimbued.prgs.rustfmt then
            vim.opt_local.equalprg = pre .. get_rustfmt_prgcall() .. post
            vim.opt_local.formatprg = pre .. get_rustfmt_prgcall() .. post
            return true
        elseif formatter == "gofmt" and nvimbued.prgs.gofmt then
            vim.opt_local.equalprg = pre .. get_gofmt_prgcall() .. post
            vim.opt_local.formatprg = pre .. get_gofmt_prgcall() .. post
            return true
        elseif formatter == "zig" and nvimbued.prgs.zig then
            vim.opt_local.equalprg = pre .. get_zig_prgcall() .. post
            vim.opt_local.formatprg = pre .. get_zig_prgcall() .. post
            return true
        elseif formatter == "dart" and nvimbued.prgs.dart then
            vim.opt_local.equalprg = pre .. get_dart_prgcall() .. post
            vim.opt_local.formatprg = pre .. get_dart_prgcall() .. post
            return true
        elseif formatter == "ktfmt" and nvimbued.prgs.ktfmt then
            vim.opt_local.equalprg = pre .. get_ktfmt_prgcall() .. post
            vim.opt_local.formatprg = pre .. get_ktfmt_prgcall() .. post
            return true
        end
    end
    return false
end

M.buf_fillermod = function(show_tab, show_multispace)
    vim.opt_local.listchars = { -- from ./lua/buffer.lua with an invisible tab
        space = ' ',
        tab = show_tab and '➾ ' or '  ',
        multispace = show_multispace and '·' or ' ',
        lead = '·',
        trail = '•',
        nbsp = '⋯'
    }
end

M.buf_tabify = function()
    vim.opt_local.expandtab = false
    M.buf_fillermod(false, true)
end

M.buf_disable = function()
    -- unbind format keymaps
    vim.cmd("noremap <buffer> = <nop>")
    vim.cmd("noremap <buffer> <leader>ff <nop>")
end

return M

