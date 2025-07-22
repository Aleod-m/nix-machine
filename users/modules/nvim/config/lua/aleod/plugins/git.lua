return {
  {
    'NeogitOrg/neogit',
    dependencies = 'nvim-lua/plenary.nvim',
    cmd = 'Neogit',
    ---@class NeogitConfig
    opts = {
      graph_style = "kitty",
      integration = {
        telescope = true,
        diffview = true,
      },
      mappings = {
        rebase_editor = {
          ["gk"] = "MoveDown",
          ["gt"] = "MoveUp",
        },
        status = {
          ["k"] = "MoveDown",
          ["t"] = "MoveUp",
          ["j"] = false,
        },
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
      current_line_blame_opts = { delay = 500 },
    }
  },
}
