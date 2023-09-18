return {  
    { 'TimUntersberger/neogit'
    , dependencies = 'nvim-lua/plenary.nvim'
    , cmd = 'Neogit'
    , config = true
    },
    -- Config 
    { 'lewis6991/gitsigns.nvim', event = "BufRead", config = { numhl = true, } },
}
