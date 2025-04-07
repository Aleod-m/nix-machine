local km = require "core.keymaps"
local leader = km.leader
return {
  "neovim/nvim-lspconfig",
  event = { "BufReadPre", "BufNewFile" },
  dependencies = {
    'saghen/blink.cmp',
    { "antosha417/nvim-lsp-file-operations", config = true },
    { -- For developpement in nvim.
      "folke/lazydev.nvim",
      ft = "lua",
      opts = {
        library = {
          -- See the configuration section for more details
          -- Load luvit types when the `vim.uv` word is found
          { path = "${3rd}/luv/library", words = { "vim%.uv" } },
        },
      },
    },
  },
  config = function()
    local lsp_conf = require'lspconfig'
    local capabilities = require("blink.cmp").get_lsp_capabilities()
    local servers = {
      "nil",
      "bashls",
      "ccls",
      "lua_ls",
      "elmls",
      "svelte",
      "wgsl_analyzer",
      "zls",
      "nushell",
      "csharp_ls",
      "gdscript",
      "ts_ls",
      "jdtls",
    }
    for _, lsp in ipairs(servers) do
      lsp_conf[lsp].setup { capabilities = capabilities }
    end
    lsp_conf.jdtls.setup {
      capabilities = capabilities,
      root_dir = function(fname)
        local root_files = {
          -- Single-module projects
          {
            'build.xml', -- Ant
            'pom.xml', -- Maven
            'settings.gradle', -- Gradle
            'settings.gradle.kts', -- Gradle
          },
          -- Multi-module projects
          { '.git', 'build.gradle', 'build.gradle.kts' },
        }
        for _, patterns in ipairs(root_files) do
          local root = require'lspconfig.util'.root_pattern(unpack(patterns))(fname)
          if root then
            return root
          end
        end
      end,
    }
    local autocmd_group = vim.api.nvim_create_augroup('AleodConfig', {clear = false})
    vim.api.nvim_create_autocmd("LspAttach", {
      group = autocmd_group,
      callback = function(args)
        local client = vim.lsp.get_client_by_id(args.data.client_id)
        client.server_capabilities.semanticTokensProvider = nil
      end,
    });

    -- Setup Autocommand for lsp keymaps and such.
    vim.api.nvim_create_autocmd('LspAttach', {
      group = autocmd_group,
      callback = function(ev)
        -- Enable completion triggered by <c-x><c-o>
        vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'
        vim.g.fmt_on_save = false

        -- Toggle format on save.
        vim.api.nvim_create_autocmd('BufWritePre', {
          group = vim.api.nvim_create_augroup('FmtOnSave', { clear = true }),
          callback = function(event)
            if vim.g.fmt_on_save then
              vim.lsp.buf.format({ bufnr = event.buf })
            end
          end,
        })

        -- Enable Inlay Hints.
        local client = vim.lsp.get_client_by_id(ev.data.client_id)
        if client ~= nil and client.server_capabilities.inlayHintProvider then
          vim.lsp.inlay_hint.enable(true, {bufnr = ev.buf})
        end

        local function exec_mapping(action, mode)
          local keys = vim.api.nvim_replace_termcodes(action, true, false, false)
          vim.api.nvim_feedkeys(keys, mode, false)
        end

        -- Buffer local mappings.
        local opts = { buffer = ev.buf }
        km.set_keymaps({
          { mode = 'n', keymap='gD', action = vim.lsp.buf.declaration, opt = opts, },
          { mode = 'n', keymap='gd', action = vim.lsp.buf.definition, opt = opts, },
          {
            mode = 'n',
            keymap='gs',
            action = function()
              exec_mapping("<C-W>v", 'n')
              exec_mapping("<C-W>l", 'n')
              exec_mapping("gd", 'n')
              exec_mapping("<C-W>p", 'n')
            end,
            opt = opts,
          },
          { mode = 'n', keymap = 'gr', action = vim.lsp.buf.references, opt = opts, },
          { mode = 'n', keymap = 'K', action = vim.lsp.buf.hover, opt = opts, },
          { mode = 'n', keymap = leader'D', action = vim.lsp.buf.type_definition, opt = opts, },
          -- Format.
          { mode = 'n', keymap = leader 'F', action = function() vim.lsp.buf.format { async = true } end, opt = opts, },
          -- Toogle format on save.
          { mode = 'n', keymap = leader 'ti', action = function() vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled()) end, opt = opts},
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
          { mode = 'n', keymap = leader 'rn', action = vim.lsp.buf.rename, opt = opts, },
          { mode = 'n', keymap = leader 'ca', action = vim.lsp.buf.code_action, opt = opts, },
        })
      end,
    })

  end
}
