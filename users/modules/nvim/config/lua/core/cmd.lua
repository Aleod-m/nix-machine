local M = {}

-- Run a command that can fail.
M.try = function(cmd)
  return function() vim.cmd[cmd]({ mods = { emsg_silent = true } }) end
end

-- Add the colon and the cariage return on the cmd.
return setmetatable(M, {
  __call = function(tb, cmd, no_cr)
    local no_cr = no_cr or false
    local cmd = "<Cmd>" .. cmd
    if no_cr then
      return cmd
    end
    return cmd .. '<Cr>'
  end
})
