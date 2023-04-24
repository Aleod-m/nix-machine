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
                type_opts = {
                    float = {
                        relative = 'editor',
                        row = 0.1,
                        col = 0.1,
                        width = 0.8,
                        height = 0.8,
                        border = "single",
                    },
                    horizontal = { location = "rightbelow", split_ratio = .4, },
                    vertical = { location = "rightbelow", split_ratio = .5 },
                },
            },
            behaviour = {
                autoclose_on_quit = {
                    enabled = true,
                    confirm = true,
                },
                close_on_exit = true,
                auto_insert = true,
            },
        }
        km.set("n", km.leader "tf", function() require("nvterm.terminal").toggle "float" end)
        km.set("n", km.leader "th", function() require("nvterm.terminal").toggle "horizontal" end)
        km.set("n", km.leader "tv", function() require("nvterm.terminal").toggle "vertical" end)
        km.set("t", km.leader "tf", function() require("nvterm.terminal").toggle "float" end)
        km.set("t", km.leader "th", function() require("nvterm.terminal").toggle "horizontal" end)
        km.set("t", km.leader "tv", function() require("nvterm.terminal").toggle "vertical" end)
    end,
})

return M
