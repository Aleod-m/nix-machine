local M = {}
M.plugins = {
  "gh:tpope/vim-dadbod",
  "gh:kristijanhusak/vim-dadbod-completion",
  "gh:kristijanhusak/vim-dadbod-ui",
}
M.config = function()
  vim.g.db_ui_use_nvim_notify = true
  vim.g.db_ui_show_database_icon = true
  vim.g.db_ui_bind_param_pattern = "@\\w\\+"
end

return M
