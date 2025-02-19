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
  {
    'lewis6991/gitsigns.nvim',
    event = "BufRead",
    opts = {
      numhl = true,
      current_line_blame = true, -- Toggle with `:Gitsigns toggle_current_line_blame`
    }
  },
}
