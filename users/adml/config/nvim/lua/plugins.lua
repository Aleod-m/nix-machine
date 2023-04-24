local plugins = require("utils.plugins")

plugins.add({
    "echasnovski/mini.nvim",
    version = "*", -- Stable release.
    config = function() 
        modules = {
            "mini.ai",
            "mini.align",
            "mini.comment",
            "mini.surround",
        }
    end
})

plugins.add('andweeb/presence.nvim')

