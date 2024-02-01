return {  
  -- TODO: Fix keymaps when issue resolved: https://github.com/NeogitOrg/neogit/issues/847
    { 'TimUntersberger/neogit'
    , dependencies = 'nvim-lua/plenary.nvim'
    , cmd = 'Neogit'
    , config = true
    },
    -- Config 
    { 'lewis6991/gitsigns.nvim', event = "BufRead", config = { numhl = true, } },
}
