return {
    'lervag/vimtex',
    ft = "tex",
    config = function(_, _)
        vim.g.vimtex_mappings_enabled = false
    end,
}
