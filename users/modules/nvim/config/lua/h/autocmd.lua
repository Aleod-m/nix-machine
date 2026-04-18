-- Help with setting autocmds
local M = { }

M.autocmds = {}
M.groups = {}
M.group = vim.api.nvim_create_augroup("AleodConfig", {})
M.groups[M.group] = true

local scope = {}
scope.group = M.group

local create = function(_scope, events, opts)
  opts.group = _scope.group
  local cmd_id = vim.api.nvim_create_autocmd(events, opts)
  M.autocmds[cmd_id] = true
  return cmd_id
end

scope.del = function(id)
    if M.autcmds[id] or false then
        return
    end
    vim.api.nvim_del_autocmd(id)
end

return setmetatable({}, {
  __call = function(_, scope_name)
    if scope_name ~= nil then
      scope.group = vim.api.nvim_create_augroup("AleodConfig." .. scope_name, {})
      M.groups[scope.group] = true
    end
    return setmetatable(scope, { __call = create })
  end
})
