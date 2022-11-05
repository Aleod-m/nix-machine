local keymaps = require'keymaps'
-- local jdtls = require'jdtls'
local M = {}

M.lsp_name = "jdtls"
M.lsp_setup = {
    capabilities = require'languages.lsp.capabilities',
    on_attach = function()
        keymaps.set("n", "K", vim.lsp.buf.hover, {buffer = 0})
        keymaps.set("n", "gd", vim.lsp.buf.definition, {buffer = 0})
        keymaps.set("n", "gT", vim.lsp.buf.type_definition, {buffer = 0})
        keymaps.set("n", "gi", vim.lsp.buf.implementation, {buffer = 0})
        keymaps.set("n", "<leader>dn", vim.diagnostic.goto_prev, {buffer = 0})
        keymaps.set("n", "<leader>dp", vim.diagnostic.goto_next, {buffer = 0})
        keymaps.set("n", "<leader>dl", "<cmd>Telescope diagnostics<CR>", {buffer = 0})
        keymaps.set("n", "<leader>ca", "<cmd>Telescope lsp_code_actions<CR>", {buffer = 0})
        keymaps.set("n", "<leader>r", vim.lsp.buf.rename, {buffer = 0})
    end,
}
-- config for the jdt Language server doesn't use lspconfig
--local working_dir = vim.fn.fnamemodify(vim.fn.getcwd(), ':p:h:t')
--local data_dir = "~/.local/share/nvim/jdtls/" .. working_dir
--M.jdtls_config = {
--    -- The command that starts the language server
--    -- See: https://github.com/eclipse/eclipse.jdt.ls#running-from-the-command-line
--    cmd = {
--        'java', -- or '/path/to/java11_or_newer/bin/java'
--        -- depends on if `java` is in your $PATH env variable and if it points to the right version.
--
--        '-Declipse.application=org.eclipse.jdt.ls.core.id1',
--        '-Dosgi.bundles.defaultStartLevel=4',
--        '-Declipse.product=org.eclipse.jdt.ls.core.product',
--        '-Dlog.protocol=true',
--        '-Dlog.level=ALL',
--        '-Xms1g',
--        '--add-modules=ALL-SYSTEM',
--        '--add-opens', 'java.base/java.util=ALL-UNNAMED',
--        '--add-opens', 'java.base/java.lang=ALL-UNNAMED',
--
--        -- 💀
--        '-jar', '/usr/share/java/jdtls/plugins/org.eclipse.equinox.launcher_1.6.400.v20210924-0641.jar',
--        -- ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^                                       ^^^^^^^^^^^^^^
--        -- Must point to the                                                     Change this to
--        -- eclipse.jdt.ls installation                                           the actual version
--
--
--        -- 💀
--        '-configuration', '/usr/share/java/jdtls/config_linux',
--        -- ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^        ^^^^^^
--        -- Must point to the                      Change to one of `linux`, `win` or `mac`
--        -- eclipse.jdt.ls installation            Depending on your system.
--
--
--        -- 💀
--        -- See `data directory configuration` section in the README
--        '-data', data_dir,  
--    },
--
--    -- 💀
--    -- This is the default if not provided, you can remove it. Or adjust as needed.
--    -- One dedicated LSP server & client will be started per unique root_dir
--    root_dir = require('jdtls.setup').find_root({'.git', 'mvnw', 'gradlew'}),
--
--    -- Here you can configure eclipse.jdt.ls specific settings
--    -- See https://github.com/eclipse/eclipse.jdt.ls/wiki/Running-the-JAVA-LS-server-from-the-command-line#initialize-request
--    -- for a list of options
--    settings = {
--        java = {
--        }
--    },
--}
--
--jdtls.start_or_attach(M.jdtls_config)
return M;
