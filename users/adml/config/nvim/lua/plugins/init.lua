return {
    {
        'TimUntersberger/neogit',
        dependencies = 'nvim-lua/plenary.nvim',
        keys = km.leader "gi" ,
        config = function()
            local neogit = require('neogit')
            local km = require('utils.keymap')
            km.set("n",  km.leader "gi", neogit.open)
        end,
    },
    { 'lewis6991/gitsigns.nvim', event = "BufRead", config = { numhl = true, } }
    { 'RRethy/nvim-align', event = "CmdlineEnter" },
    { 'folke/neodev.nvim', opts = {} },
}
