local accept_idx = function(nb) return function(cmp) cmp.accept({ index = nb }) end end
return {
  'saghen/blink.cmp',
  -- optional: provides snippets for the snippet source
  dependencies = {
    'rafamadriz/friendly-snippets',
    "kristijanhusak/vim-dadbod-completion",
  },

  -- use a release tag to download pre-built binaries
  version = '*',

  ---@module 'blink.cmp'
  ---@type blink.cmp.Config
  opts = {

    keymap = {
      preset = 'enter',
      ['<A-1>'] = { accept_idx(1) },
      ['<A-2>'] = { accept_idx(2) },
      ['<A-3>'] = { accept_idx(3) },
      ['<A-4>'] = { accept_idx(4) },
      ['<A-5>'] = { accept_idx(5) },
      ['<A-6>'] = { accept_idx(6) },
      ['<A-7>'] = { accept_idx(7) },
      ['<A-8>'] = { accept_idx(8) },
      ['<A-9>'] = { accept_idx(9) },
      ['<A-0>'] = { accept_idx(10) },
    },

    completion = {
      list = { selection = { preselect = false, auto_insert = true } },
      menu = {
        draw = {
          columns = {
            { 'item_idx' },
            { 'kind_icon' },
            { 'label',    'label_description', gap = 1 },
          },
          components = {
            item_idx = {
              text = function(ctx)
                return ctx.idx == 10 and '0'
                    or ctx.idx >= 10 and ' '
                    or tostring(ctx.idx)
              end,
              highlight = 'BlinkCmpItemIdx' -- optional, only if you want to change its color
            }
          }
        }
      }
    },
    sources = {
      default = { 'lsp', 'path', 'snippets', 'buffer' },
      cmdline = {
        keymap = {
          preset = 'inherit',
          ['<A-1>'] = { accept_idx(1) },
          ['<A-2>'] = { accept_idx(2) },
          ['<A-3>'] = { accept_idx(3) },
          ['<A-4>'] = { accept_idx(4) },
          ['<A-5>'] = { accept_idx(5) },
          ['<A-6>'] = { accept_idx(6) },
          ['<A-7>'] = { accept_idx(7) },
          ['<A-8>'] = { accept_idx(8) },
          ['<A-9>'] = { accept_idx(9) },
          ['<A-0>'] = { accept_idx(10) },
        },
      },
      per_filetype = {
        sql = { 'dadbod', 'buffer' },
        mysql = { 'dadbod', 'buffer' },
      },
      providers = {
        dadbod = { name = "Dadbod", module = "vim_dadbod_completion.blink" },
        lsp = {
          name = 'LSP',
          module = 'blink.cmp.sources.lsp',
          async = true,
          transform_items = function(_, items)
            return vim.table_filter(function(item)
              local kind = require('blink.cmp.types').CompletionItemKind
              return item.kind ~= kind.Keywords or item.kind ~= kind.Snippet
            end, items)
          end,
        }
      },
    },
    -- Experimental signature help support
    signature = { enabled = true }
  },
  opts_extend = { "sources.default" }
}
