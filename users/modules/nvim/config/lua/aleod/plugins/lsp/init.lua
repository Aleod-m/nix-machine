return {
  "neovim/nvim-lspconfig",
  event = { "BufReadPre", "BufNewFile" },
  dependencies = {
    "hrsh7th/cmp-nvim-lsp",
    { "antosha417/nvim-lsp-file-operations", config = true },
  },
  config = function(_, _)
    vim.api.nvim_create_autocmd('LspAttach', {
      group = vim.api.nvim_create_augroup('AleodConfig', {clear = false}),
      callback = function(ev)
        -- Enable completion triggered by <c-x><c-o>
        vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'

        -- Enable Inlay Hints.
        local client = vim.lsp.get_client_by_id(ev.data.client_id)
        if client.server_capabilities.inlayHintProvider then
            vim.lsp.inlay_hint.enable(true, {bufnr = ev.buf})
        end
        -- Buffer local mappings.
        -- See `:help vim.lsp.*` for documentation on any of the below functions
        local opts = { buffer = ev.buf }
        vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
        vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
        vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
        vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
        vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, opts)
        vim.keymap.set('n', '<space>F', function() vim.lsp.buf.format { async = true } end, opts)
        vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, opts)
        vim.keymap.set({ 'n', 'v' }, '<space>ca', vim.lsp.buf.code_action, opts)
      end
    })

    -- Servers using default config.
    local lsp_conf = require'lspconfig'
    local capabilities = require("cmp_nvim_lsp").default_capabilities()
    local servers = {
      "nil",
      "ccls",
      "elmls",
      "svelte",
      "wgsl_analyzer",
      "zls",
      "nushell",
    }

    for _, lsp in ipairs(servers) do 
      lsp_conf[lsp].setup { capabilities = capabilities }
    end

    -- Servers using custom config.
    lsp_conf.lua_ls.setup({
      capabilities = capabilities,
      settings = {
        Lua = {
          -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
          runtime = { version = 'LuaJIT' }, 
          -- Get the language server to recognize the `vim` global
          diagnostics = { globals = {'vim'} } ,
          -- Make the server aware of Neovim runtime files
          workspace = { library = vim.api.nvim_get_runtime_file("", true) } ,
          -- Do not send telemetry data containing a randomized but unique identifier
          telemetry = { enable = false },
        }
      },
    })
  end
}
