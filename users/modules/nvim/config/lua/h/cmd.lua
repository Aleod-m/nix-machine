local M = {}

-- Run a command that can fail.
M.try = function(cmd)
  return function() vim.cmd[cmd]({ mods = { emsg_silent = true } }) end
end

M.win = vim.cmd.wincmd

M.create = vim.api.nvim_create_user_command

-- Add the colon and the cariage return on the cmd.
return setmetatable(M, {
  __call = getmetatable(vim.cmd).__call
})
