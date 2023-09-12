local autocmd = require"utils.autocmd"

autocmd.create({"BufEnter", "BufNewFile"}, {
    pattern = "*.wgsl",
    callback = function() vim.bo.filetype="wgsl" end,
})

local M = {}

function M.setup_lsp()
    local lsp = require'lspconfig'
    lsp.wgsl_analyzer.setup{}
end

function M.setup_TS() 
    local parser_config = require "nvim-treesitter.parsers".get_parser_configs()
    parser_config.wgsl = {
        install_info = {
            url = "https://github.com/theHamsta/tree-sitter-wgsl-bevy",
            files = {"src/parser.c"}
        },
    }
    return "wgsl"
end

return M
