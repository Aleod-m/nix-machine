
return {
  "neovim/nvim-lspconfig",
  event = { "BufReadPre", "BufNewFile" },
  dependencies = {
    "hrsh7th/cmp-nvim-lsp",
    { "antosha417/nvim-lsp-file-operations", config = true },
  },
  config = function(_, _)

    -- Setup Autocommand for lsp keymaps and such.
    vim.api.nvim_create_autocmd('LspAttach', {
      group = vim.api.nvim_create_augroup('AleodConfig', {clear = false}),
      callback = function(ev)
        -- Enable completion triggered by <c-x><c-o>
        vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'
        vim.g.fmt_on_save = false

        vim.api.nvim_create_autocmd('BufWritePre', {
          group = vim.api.nvim_create_augroup('FmtOnSave', { clear = true }),
          callback = function(ev) 
            if vim.g.fmt_on_save then
              vim.lsp.buf.format({ bufnr = ev.buf }) 
            end
          end,
        })

        -- Enable Inlay Hints.
        local client = vim.lsp.get_client_by_id(ev.data.client_id)
        if client.server_capabilities.inlayHintProvider then
            vim.lsp.inlay_hint.enable(true, {bufnr = ev.buf})
        end

        -- Buffer local mappings.
        local km = require "core.keymaps"
        local leader = km.leader
        local opts = { buffer = ev.buf }
        km.set_keymaps({
            { mode = 'n', keymap='gD', action = vim.lsp.buf.declaration, opt = opts, },
            { mode = 'n', keymap='gd', action = vim.lsp.buf.definition, opt = opts, },
            { mode = 'n', keymap='gr', action = vim.lsp.buf.references, opt = opts, },
            { mode = 'n', keymap='K', action = vim.lsp.buf.hover, opt = opts, },
            { mode = 'n', keymap=leader'D', action = vim.lsp.buf.type_definition, opt = opts, },
            -- Format.
            { mode = 'n', keymap=leader 'F', action = function() vim.lsp.buf.format { async = true } end, opt = opts, },
            -- Toogle format on save.
            { mode = 'n', keymap=leader 'ti', action = function() vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled()) end, opt = opts},
            {
              mode = 'n',
              keymap='<space>ft',
              action = function()
                vim.g.fmt_on_save = not vim.g.fmt_on_save
                local state = nil;
                if vim.g.fmt_on_save then
                  state = "enabled."
                else
                  state = "disabled."
                 end
                 print ("Format on save " .. state)
              end,
              opt = opts,
            },
              
            { mode = 'n', keymap='<space>rn', action = vim.lsp.buf.rename, opt = opts, },
            { mode = 'n', keymap = '<space>ca', action = vim.lsp.buf.code_action, opt = opts, },
        })
      end,
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
      "csharp_ls",
      "gdscript",
    }

    for _, lsp in ipairs(servers) do 
      lsp_conf[lsp].setup { capabilities = capabilities }
    end

    -- local omnisharp = vim.iter(vim.gsplit(vim.fn.deepcopy(vim.env.PATH), ":"))
    --         :filter(function(path) local m = path:match(".*omnisharp.*") return m ~= nil end):next()
    --
    -- lsp_conf.omnisharp.setup {
    --     capabilities = capabilities,
    --     root_dir = lsp_conf.util.root_pattern("*.sln", "*.csproj", "*.git"),
    --     cmd = {omnisharp, "--languageserver", "--hostPID", tostring(vim.fn.getpid())},
    -- }

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
