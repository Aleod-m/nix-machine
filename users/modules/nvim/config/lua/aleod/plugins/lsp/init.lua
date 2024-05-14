
return {
  "neovim/nvim-lspconfig",
  event = { "BufReadPre", "BufNewFile" },
  dependencies = {
    "hrsh7th/cmp-nvim-lsp",
    { "antosha417/nvim-lsp-file-operations", config = true },
  },
  config = function(_, _)
    local km = require "core.keymaps"
    local leader = km.leader

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
        km.set_keymaps({
            {mode = 'n', keymap='gD', action = vim.lsp.buf.declaration, opts},
            {mode = 'n', keymap='gd', action = vim.lsp.buf.definition, opts},
            {mode = 'n', keymap='gr', action = vim.lsp.buf.references, opts},
            {mode = 'n', keymap='K', action = vim.lsp.buf.hover, opts},
            {mode = 'n', keymap='<space>D', action = vim.lsp.buf.type_definition, opts},
            -- Format.
            {mode = 'n', keymap='<space>F', action = function() vim.lsp.buf.format { async = true } end, opts},
            -- Toogle format on save.
            {
              mode = 'n',
              keymap='<space>ft',
              action = function()
                if vim.g.fmt_on_save ~= nil && vim.g.fmt_on_save then 
                  -- Fmt on save is active disable it.
                  vim.api.nvim_clear_autocmds({group = 'FmtOnSave'})
                  vim.g.fmt_on_save = false 
                else 
                  -- Fmt on save is inactive enable it.
                  vim.api.nvim_create_autocmd('BufWritePre', {
                    group = vim.api.nvim_create_augroup('FmtOnSave', { clear = true })
                    callback = function(ev) vim.lsp.buf.format({bufnr = ev.buf }) end
                  })
                  vim.g.fmt_on_save = true 
                end
              end,
              opts
            },
            {mode = 'n', keymap='<space>rn', action = vim.lsp.buf.rename, opts},
            {mode = { 'n', 'v' }, '<space>ca', action = vim.lsp.buf.code_action, opts},
        })
    })

    -- Toggle format on save.
    vim.api.nvim_create_autocmd('BufWritePre', {
      group = vim.api.nvim
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
