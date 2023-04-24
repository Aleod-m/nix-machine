local plugins = require("utils.plugins")
local km = require('utils.keymaps')

plugins.add({
    'TimUntersberger/neogit',
    dependencies = 'nvim-lua/plenary.nvim',
    keys = km.leader "gi" ,
    config = function()
        local neogit = require('neogit')
        km.set("n",  km.leader "gi", neogit.open)
    end,
})

plugins.add({
    'lewis6991/gitsigns.nvim',
    event = "BufRead",
    config = {
        numhl = true,
        on_attach = function(bufnb)
        end,
    }
})
