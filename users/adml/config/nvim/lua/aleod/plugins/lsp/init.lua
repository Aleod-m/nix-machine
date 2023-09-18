return {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
        "hrsh7th/cmp-nvim-lsp",
        { "antosha417/nvim-lsp-file-operations", config = true }
    },
    config = function()
        local cmp_lsp = require("cmp_nvim_lsp")
        local lsp = vim.lsp
        local opts = 
            -- Lsp capabilities.
            { capabilities = cmp_lsp.default_capabilities()
            -- Attach function.
            , on_attach = vim.lsp.on_attach
            }

        lsp.capabilities = opts.capabilities
        lsp.on_attach = opts.on_attach

        local lsp_conf = require'lspconfig'
        lsp_conf.rnix.setup(opts)
        lsp_conf.ccls.setup(opts)
        lsp_conf.elmls.setup(opts)
        lsp_conf.svelte.setup(opts)
        lsp_conf.wgsl_analyzer.setup(opts)
        lsp_conf.zls.setup(opts)
        lsp_conf.lua_ls.setup(
            vim.tbl_extend("force", opts,
                { settings = 
                    { Lua = 
                        -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
                        { runtime = { version = 'LuaJIT' }
                        -- Get the language server to recognize the `vim` global
                        , diagnostics = { globals = {'vim'} }
                        -- Make the server aware of Neovim runtime files
                        , workspace = { library = vim.api.nvim_get_runtime_file("", true) }
                        -- Do not send telemetry data containing a randomized but unique identifier
                       , telemetry = { enable = false },
                       }
                    }
                }
            )
        )
    end
}
