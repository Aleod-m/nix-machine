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
      ['<A-1>'] = { function(cmp) cmp.accept({ index = 1 }) end },
      ['<A-2>'] = { function(cmp) cmp.accept({ index = 2 }) end },
      ['<A-3>'] = { function(cmp) cmp.accept({ index = 3 }) end },
      ['<A-4>'] = { function(cmp) cmp.accept({ index = 4 }) end },
      ['<A-5>'] = { function(cmp) cmp.accept({ index = 5 }) end },
      ['<A-6>'] = { function(cmp) cmp.accept({ index = 6 }) end },
      ['<A-7>'] = { function(cmp) cmp.accept({ index = 7 }) end },
      ['<A-8>'] = { function(cmp) cmp.accept({ index = 8 }) end },
      ['<A-9>'] = { function(cmp) cmp.accept({ index = 9 }) end },
      ['<A-0>'] = { function(cmp) cmp.accept({ index = 10 }) end },
    },

    completion = {
      list = { selection = { preselect = false, auto_insert = true } },
      menu = {
        draw = {
          columns = { { 'item_idx' }, { 'kind_icon' }, { 'label', 'label_description', gap = 1 } },
          components = {
            item_idx = {
              text = function(ctx) return ctx.idx == 10 and '0' or ctx.idx >= 10 and ' ' or tostring(ctx.idx) end,
              highlight = 'BlinkCmpItemIdx' -- optional, only if you want to change its color
            }
          }
        }
      }
    },
    sources = {
      default = { 'lsp', 'path', 'snippets', 'buffer' },
      per_filetype = {
        sql = { 'dadbod', 'buffer' },
        mysql = { 'dadbod', 'buffer' },
      },
      providers = {
        dadbod = { name = "Dadbod", module = "vim_dadbod_completion.blink" },
        lsp = {
          name = 'LSP',
          module = 'blink.cmp.sources.lsp',
          transform_items = function(_, items)
            return vim.table_filter(function (item) 
              local ty = require('blink.cmp.types').CompletionItemKind
              return item.kind ~= ty.Keywords or item.kind ~= ty.Snippet
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
