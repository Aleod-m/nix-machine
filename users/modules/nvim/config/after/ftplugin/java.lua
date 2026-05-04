vim.bo.expandtab = false

local function build_cmd(args)
  return vim.tbl_filter(function(arg) return arg ~= nil end, args)
end

local home = vim.env.HOME
local root_dir = vim.fs.root(0, { { '.git', 'gradlew', 'mvnw' }, { 'pom.xml' } })
    or vim.fn.fnamemodify(vim.fn.getcwd(), ':p:h:t')
local data_dir = home .. "/.cache/jdtls/projects/" .. vim.fn.sha256(root_dir)

local config = {
  name = "jdtls",
  cmd = build_cmd{ 'jdtls', vim.env.JDTLS_JVM_ARGS, '-data', data_dir },
  root_dir = root_dir,
}

require('jdtls').start_or_attach(config)
