local M = {}

M.get_ignored_files = function(pwd)
    local p = pwd ~= nil
        and io.popen("git -C " ..
        pwd .. " ls-files --other --ignored --exclude-standard --directory 2>/dev/null || echo")
        or io.popen("git ls-files --other --ignored --exclude-standard --directory 2>/dev/null || echo")
    if p ~= nil then
        local result = p:read("*a")
        p:close()
        return vim.split(result, '\n', { plain = true, trimempty = true })
    end
    return {}
end

return M

