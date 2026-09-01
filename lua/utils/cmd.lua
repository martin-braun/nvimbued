local sys = require("utils.sys")
local M = {}

M.get_resolved_invoker_of = function(command)
    local p = sys.is_windows()
        and io.popen("where " .. command .. " 2>/dev/null || echo")
        or io.popen("command -v " .. command .. " 2>/dev/null || echo")
    if p ~= nil then
        local result = p:read()
        p:close()
        if #result > 0 then
            return result
        end
    end
    return nil
end

return M

