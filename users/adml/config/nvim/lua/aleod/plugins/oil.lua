return {
    'stevearc/oil.nvim',
    lazy = false,

    -- Optional dependencies
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
        local km, cmd = require'core.keymaps', require'core.cmd'
        require'oil'.setup()
        km.set('n', "-", cmd 'Oil')
        local g = vim.api.nvim_create_augroup("oil-startup", {clear = false})
        vim.api.nvim_create_autocmd({'BuffEnter'}, {
            group = g
            , callback = function()
                if vim.fn.argc() == 0 then
                    require'oil'.open(vim.fn.getcwd())
                    vim.api.nvim_clear_autocmds({group = g})
                end
            end
        })
    end
}
