-- Allows to add specialisations by sourcing directories in lua/config_name

local configs = vim.split(vim.env.NVIM_CONFIG or '', ',')
require('h').load_config(
  vim.tbl_extend('keep', {'aleod'}, configs)
)
