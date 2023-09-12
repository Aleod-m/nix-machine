return {
    dependancies = "neovim/nvim-lspconfig",
    ft = 'nix'
    config = function() 
        require'lspconfig'.rnix.setup{}
    end
}
