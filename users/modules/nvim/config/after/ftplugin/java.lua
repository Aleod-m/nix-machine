vim.o.expandtab = false
local home = vim.env.HOME
local root_dir = vim.fs.root(0, { { '.git', 'gradlew', 'mvnw' }, { 'pom.xml' } })
    or vim.fn.fnamemodify(vim.fn.getcwd(), ':p:h:t')
local data_dir = home .. "/.cache/jdtls/projects/" .. vim.fn.sha256(root_dir)
local config = {
  name = "jdtls",
  cmd = { "jdtls", '-data', data_dir },
  root_dir = root_dir,
}
require('jdtls').start_or_attach(config)
