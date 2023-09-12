local keymaps = require"keymaps"
local M = {}
-- Lsp Setup.
M.lsp_name = 'elmls'
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

return M
