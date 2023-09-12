return {
    'AdrienDML/konokai',
    lazy = false,
    priority = 1000,
    dependencies = {
        'rktjmp/lush.nvim',
    },
    config = function() vim.cmd [[colorscheme konokai]] end,
}
