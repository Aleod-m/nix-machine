return {
  {
    'TimUntersberger/neogit',
    dependencies = 'nvim-lua/plenary.nvim',
    cmd = 'Neogit',
    opts = {
      mappings = {
        popup = {
          ["l"] = false,
          ["L"] = "LogPopup",
          ["t"] = false,
          ["T"] = "TagPopup",
        },
      },
    },
  },
   -- Config 
  { 'lewis6991/gitsigns.nvim', event = "BufRead", opts = { numhl = true, } },
}
