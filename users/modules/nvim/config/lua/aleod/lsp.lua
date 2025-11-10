local autocmd = require('core.autocmd')('Lsp')
local km = require('core.keymaps')
local leader = km.leader

-- Servers with default configuration
vim.lsp.enable({
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
  "pylsp",
  "ts_ls",
  "jdtls",
  "spectral",
  "rust_analyzer",
})

vim.g.fmt_on_save = false

-- Format buffer using lsp if fmt on save is enabled.
autocmd('BufWritePre', {
  callback = function(event)
    if vim.g.fmt_on_save then
      vim.lsp.buf.format({ bufnr = event.buf })
    end
  end,
})

autocmd("LspAttach", {
  callback = function(ev)
    -- Setup completions
    vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'

    -- Tweak client settings
    local client = vim.lsp.get_client_by_id(ev.data.client_id)
    if client ~= nil then
      -- If inlay hints are available enable them.
      if client.server_capabilities.inlayHintProvider then
        vim.lsp.inlay_hint.enable(true, {bufnr = ev.buf})
      end
      -- Prefer treesitter highlights, disable lsp highlighting.
      client.server_capabilities.semanticTokensProvider = nil
    end

    local opts = { buffer = ev.buf }
    km.set_keymaps({
      { mode = 'n', keymap='gD', action = vim.lsp.buf.declaration, opt = opts, },
      { mode = 'n', keymap='gd', action = vim.lsp.buf.definition, opt = opts, },
      { mode = 'n', keymap = 'gr', action = vim.lsp.buf.references, opt = opts, },
      { mode = 'n', keymap = 'K', action = vim.lsp.buf.hover, opt = opts, },
      { mode = 'n', keymap = leader'D', action = vim.lsp.buf.type_definition, opt = opts, },
      -- Format.
      {
        mode = 'n',
        keymap = leader 'F',
        action = function() vim.lsp.buf.format { async = true } end,
        opt = opts,
      },
      -- Toogle inlay_hints on save.
      {
        mode = 'n',
        keymap = leader 'ti',
        action = function()
          vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
        end,
        opt = opts
      },
      -- Toogle format on save.
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
  end
})
