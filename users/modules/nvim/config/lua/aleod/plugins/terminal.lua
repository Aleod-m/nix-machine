return {
    "NvChad/nvterm",
    keys = {
        "<Leader>tf",
        "<Leader>th",
        "<Leader>tv",
    },
    config = function()
        local nvt = require('nvterm')
        local km = require('core.keymaps')
        local cmd = require('core.cmd')
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
                auto_insert = false,
            },
        }
        local T = require("nvterm.terminal")
        km.set("t", km.leader "<Esc>", cmd 'stopinsert')
        km.set("n", km.leader "tf", function() T.toggle "float" end)
        km.set("n", km.leader "th", function() T.toggle "horizontal" end)
        km.set("n", km.leader "tv", function() T.toggle "vertical" end)
    end,
}
