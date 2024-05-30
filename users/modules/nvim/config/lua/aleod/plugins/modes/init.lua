-- Agglomerate modes.
local modes = {
    require("aleod.plugins.modes.window"),
    require("aleod.plugins.modes.git"),
}

local M = {
    keys = {},
    dependencies = {},
}

for _, mode in ipairs(modes) do
    M.dependencies = vim.list_extend(M.dependencies, mode.dependencies) 
    M.keys = vim.list_extend(M.keys, mode.keys)
end

return {
  'nvimtools/hydra.nvim',
  dependecies = M.dependencies,
  keys = M.keys,
  config = function()
    local hydra = require('hydra')
    for _, mode in ipairs(modes) do
        hydra(mode.mode())
    end
  end,
}
