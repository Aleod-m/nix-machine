local plugins = require("utils.plugins")
local M = {}

plugins.add({
    "NvChad/nvterm",
    config = function()
        local nvt = require('nvterm')
        local km = require('utils.keymaps')
        nvt.setup {
            terminals = {
                shell = "nu",
            },
        }
    end,
})

return M
