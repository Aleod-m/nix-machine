local M = {}
-- Add the colon and the cariage return on the cmd.
local fmt = function(cmd, no_cr = false)
    local no_cr = no_cr or false
    local cmd = "<Cmd>" .. cmd
    if no_cr then
        return cmd 
    end
    return cmd .. '<cr>'
end

-- Run a command that can fail.
M.try = function(cmd)
    return function() pcall(vim.cmd(fmt(cmd))) end
end

return setmetatable(M, {
    __call = function (tb, cmd, no_cr)
        vim.cmd(fmt(cmd, no_cr))
    end
})
