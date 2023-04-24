local plugins = require("utils.plugins")

plugins.add({
    'anuvyklack/hydra.nvim', 
    lazy = false,
    -- needed only for pink hydras
    dependencies = 'anuvyklack/keymap-layer.nvim',
})

local M = {}
local mnames = {}
mnames["n"] = "Normal"
mnames["v"] = "Visual"
mnames["V"] = "Visual-Line"
mnames["i"] = "Insert"
mnames["t"] = "Terminal"
mnames["CTRL-V"] = "Visual-Block"

function M.active()
    local status = require("hydra.statusline")
    local active_mode = nil
    if status.is_active() then
        active_mode = status.get_name()
    else 
        local mode = vim.fn.mode()
        active_mode = mnames[mode]     
    end
    return active_mode or "Unknown"
end

function M.add(mode)
    local Hydra = require("hydra")
    Hydra(mode)
end

return M
