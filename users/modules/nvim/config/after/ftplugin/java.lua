vim.bo.expandtab = false

local home = vim.env.HOME
local root_dir = vim.fs.root(0, { { '.git', 'gradlew', 'mvnw' }, { 'pom.xml' } })
    or vim.fn.fnamemodify(vim.fn.getcwd(), ':p:h:t')
local data_dir = home .. "/.cache/jdtls/projects/" .. vim.fn.sha256(root_dir)

local config = {
  name = "jdtls",
  cmd = {
    "jdtls",
    "-data-dir", data_dir,
  },
  root_dir = root_dir,
}

if vim.env.JDTLS_JVM_ARGS then
  local jvm_args = vim.split(vim.env.JDTLS_JVM_ARGS, ';', {plain = true})
  for _, arg in ipairs(jvm_args) do
    config.cmd[#config.cmd+1] = "--jvm-arg="..arg
  end
end

require('jdtls').start_or_attach(config)
