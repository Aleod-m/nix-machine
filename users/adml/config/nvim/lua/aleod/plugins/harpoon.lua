return {
    "ThePrimeagen/harpoon",
    keys = {
        "<leader>hh",
        "<leader>hn",
        "<leader>hp",
    },
    dependencies = {
        "nvim-lua/plenary.nvim",
    },
    config = function()
        local km = require('core.keymaps')
        local leader = km.leader

        km.set_keymaps({
            { mode = "n", keymap = leader "hh", action = require("harpoon.mark").add_file },
            { mode = "n", keymap = leader "hn", action = require("harpoon.ui").nav_next },
            { mode = "n", keymap = leader "hp", action = require("harpoon.ui").nav_prev },
        })
    end
}
