local M = {}
-- Add the colon and the cariage return on the cmd.
local fmt = function(cmd)
    return "<Cmd>" .. cmd .. "<Cr>"
end

-- Add only the colon at the start.
-- to use when user input is required
local no_cr_fmt = function(cmd)
    return "<Cmd>" .. cmd 
end

-- Run a command that can fail.
M.try = function(cmd)
    return function() pcall(vim.cmd(cmd)) end
end

return setmetatable(M, {
    __call = function (tb, cmd, no_cr)
        if (no_cr ~= nil) then 
            return no_cr_fmt(cmd)
        end
        return fmt(cmd)
    end
})
