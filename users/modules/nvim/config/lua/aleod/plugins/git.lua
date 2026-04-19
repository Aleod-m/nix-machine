local M = {}
M.plugins = {
  'gh:NeogitOrg/neogit',
  'gh:nvim-lua/plenary.nvim', -- Neogit dep
  'gh:lewis6991/gitsigns.nvim',
}
M.config = function()
  require'gitsigns'.setup({
    numhl = true,
    current_line_blame = true, -- Toggle with `:Gitsigns toggle_current_line_blame`
    current_line_blame_opts = { delay = 500 },
  })
  require'neogit'.setup({
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
  })
end

return M
