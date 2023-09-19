return {
    'stevearc/oil.nvim',
    lazy = false,

    -- Optional dependencies
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
        local km, cmd = require'core.keymaps', require'core.cmd'
        require'oil'.setup()
        km.set('n', "-", cmd 'Oil')
    end
}
