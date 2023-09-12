local plugins = require("utils.plugins")
plugins.add({
    'lervag/vimtex',
    ft = "tex",
    setup = function()
        vim.g.vimtex_mappings_enabled = false
    end,
})

local M = {}
M.name = "latex"
return M
