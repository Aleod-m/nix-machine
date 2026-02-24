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

    appearance = {
      highlight_ns = vim.api.nvim_create_namespace('blink_cmp'),
      -- Sets the fallback highlight groups to nvim-cmp's highlight groups
      -- Useful for when your theme doesn't support blink.cmp
      -- Will be removed in a future release
      use_nvim_cmp_as_default = false,
      -- Set to 'mono' for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
      -- Adjusts spacing to ensure icons are aligned
      nerd_font_variant = 'mono',
      kind_icons = {
        Text = '󰉿 ',
        Method = '󰊕 ',
        Function = '󰊕 ',
        Constructor = '󰒓',

        Field = '󰜢',
        Variable = '󰆦',
        Property = '󰖷',

        Class = '󱡠',
        Interface = '󱡠',
        Struct = '󱡠',
        Module = '󰅩',

        Unit = '󰪚',
        Value = '󰦨',
        Enum = '󰦨',
        EnumMember = '󰦨',

        Keyword = '󰻾',
        Constant = '󰏿',

        Snippet = '󱄽',
        Color = '󰏘',
        File = '󰈔',
        Reference = '󰬲',
        Folder = '󰉋',
        Event = '󱐋',
        Operator = '󰪚',
        TypeParameter = '󰬛',
      },
    },
    completion = {
      list = { selection = { preselect = false, auto_insert = true } },
      menu = {
        cmdline_position = function()
          if vim.g.ui_cmdline_pos ~= nil then
            local pos = vim.g.ui_cmdline_pos -- (1, 0)-indexed
            return { pos[1] - 1, pos[2] }
          end
          local height = (vim.o.cmdheight == 0) and 1 or vim.o.cmdheight
          return { vim.o.lines - height, 0 }
        end,
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
    cmdline = {
      keymap = {
        preset = 'cmdline',
        ['<Tab>'] = { 'show', 'accept' },
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
    sources = {
      default = { 'lsp', 'path', 'snippets', 'buffer' },
      per_filetype = {
        sql = { 'dadbod', 'buffer' },
        mysql = { 'dadbod', 'buffer' },
      },
      providers = {
        dadbod = { name = "Dadbod", module = "vim_dadbod_completion.blink" },
      },
    },
    -- Experimental signature help support
    signature = { enabled = true }
  },
  opts_extend = { "sources.default" }
}
