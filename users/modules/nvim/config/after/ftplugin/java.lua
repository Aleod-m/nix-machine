vim.o.expandtab = false
local config = {
  name = "jdtls",
  cmd = "jdtls",
  root_dir = vim.fs.root(0, { '.git' }),
}
require('jdtls').start_or_attach(config)
