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
    if mode.dependecies ~= nil then
        M.dependencies = vim.list_extend(M.dependecies, mode.dependecies)
    end
    if mode.keys ~= nil then
        M.keys = vim.list_extend(M.keys, mode.keys)
    end
end

--return {
--  'anuvyklack/hydra.nvim',
--  dependecies = dependecies,
--  keys = keys,
--  config = function()
--    for _, mode in ipairs(modes) do
--        mode.config()
--    end
--  end,
--}
