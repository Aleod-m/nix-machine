local km = require"utils.keymaps"
local M = {}
-- Lsp Setup 
M.lsp_name = "ccls"
M.lsp_setup = {
    capabilities = require'languages.lsp.capabilities',
    on_attach = function()
        km.set("n", "K", vim.lsp.buf.hover, {buffer = 0})
        km.set("n", "gd", vim.lsp.buf.definition, {buffer = 0})
        km.set("n", "gT", vim.lsp.buf.type_definition, {buffer = 0})
        km.set("n", "gi", vim.lsp.buf.implementation, {buffer = 0})
        km.set("n", "<leader>ca", vim.lsp.buf.code_action, {buffer = 0})
        km.set("n", "<leader>r", vim.lsp.buf.rename, {buffer = 0})
    end,
    init_options = {
        compilationDatabaseDirectory = "build";
    },
}
return M
