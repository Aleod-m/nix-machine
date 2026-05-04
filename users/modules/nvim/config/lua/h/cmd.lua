local M = {}

-- Run a command that can fail.

M.try = function(cmd)
  vim.cmd[cmd]({ mods = { emsg_silent = true } })
end

-- Builds a string for a shell command from a table
M.shell = function(cmd, args, arg_val_sep)
  arg_val_sep = arg_val_sep or '='
  for arg, val in ipairs(args) do
    if val and type(val) == "boolean" then
      cmd = cmd .. ' ' .. arg
    elseif type(val) == "string" then
      cmd = cmd .. ' ' .. arg .. arg_val_sep .. val
    else
      goto continue
    end
    ::continue::
  end

  return cmd
end


M.win = vim.cmd.wincmd

M.create = vim.api.nvim_create_user_command

-- Add the colon and the cariage return on the cmd.
return setmetatable(M, {
  __call = getmetatable(vim.cmd).__call
})
