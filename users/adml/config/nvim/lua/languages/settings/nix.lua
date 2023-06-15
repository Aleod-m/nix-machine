local M = {}

function M.setup_TS() return "nix" end
function M.setup_lsp()
    local lsp = require'lspconfig'
    lsp.rnix.setup {
        on_attach = function()
            local km = require "utils.keymaps"
            km.set("n", "K", vim.lsp.buf.hover, {buffer = 0})
            km.set("n", "gd", vim.lsp.buf.definition, {buffer = 0})
            km.set("n", "gT", vim.lsp.buf.type_definition, {buffer = 0})
            km.set("n", "gi", vim.lsp.buf.implementation, {buffer = 0})
            km.set("n", "<leader>dn", vim.diagnostic.goto_prev, {buffer = 0})
            km.set("n", "<leader>dp", vim.diagnostic.goto_next, {buffer = 0})
            km.set("n", "<leader>dl", "<cmd>Telescope diagnostics<CR>", {buffer = 0})
            km.set("n", "<leader>ca", "<cmd>Telescope lsp_code_actions<CR>", {buffer = 0})
            km.set("n", "<leader>r", vim.lsp.buf.rename, {buffer = 0})
        end
    }
end

return M
