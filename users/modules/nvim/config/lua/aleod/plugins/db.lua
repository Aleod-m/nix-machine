return {
	"tpope/vim-dadbod",
  dependencies = {
    "kristijanhusak/vim-dadbod-completion",
    "kristijanhusak/vim-dadbod-ui",
  },
  config = function()
    vim.g.db_ui_use_nvim_notify = true
    vim.g.db_ui_show_database_icon = true
    vim.g.db_ui_bind_param_pattern = "@\\w\\+"
  end
}
