local M = {}

M.plugins = { 'gh:nvimtools/hydra.nvim' }

-- Agglomerate modes.
local modes = {
    require("aleod.plugins.modes.window"),
    require("aleod.plugins.modes.git"),
}

for _, mode in ipairs(modes) do
    M.plugins = vim.list_extend(M.plugins, mode.dependencies)
end

M.config = function()
  local hydra = require('hydra')
  for _, mode in ipairs(modes) do
    hydra(mode.mode())
  end
end

return M
