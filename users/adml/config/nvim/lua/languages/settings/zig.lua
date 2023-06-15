local plugins = require("utils.plugins")

local M = {}

function M.setup_TS() 
    return "zig" 
end

function M.setup_lsp()
    local lsp = require'lspconfig'
    lsp.zls.setup {
        on_attach = require('languages.lsp').on_attach_fn,
        capabilities = require('languages.lsp.capabilities'),
    }
end

return M
