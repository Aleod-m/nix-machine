return {
  -- My theme
  {
    'Aleod-m/konokai',
    lazy = false,
    dependencies = {
      'rktjmp/lush.nvim',
    },
    config = function(_, _) vim.cmd [[colorscheme konokai]] end,
  },
  -- Status bar theme
  {
    'nvim-lualine/lualine.nvim',
    lazy = false,
    opts = {
      options = {
        icons_enabled = true,
        theme = require'konokai.themes'.lualine,
        section_separators = { left = '', right = '' },
        component_separators = { left = '', right = '' },
      },
      winbar = {
        lualine_a = { 'mode' },
        lualine_b = {
          {
            'filename',
            file_status=true,
            path=1,
            symbols= {
              modified=" ",
              readonly=" ",
              unnamed="NONAME"
            }
          },
          'branch'
        },
        lualine_c = {'diff', 'diagnostics'},
        lualine_x = {'encoding', {'filetype', colored=true}},
        lualine_y = {},
        lualine_z = {'location'}
      },
      inactive_winbar = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = {'filename'},
        lualine_x = {'location'},
        lualine_y = {},
        lualine_z = {}
      },
    }
  },
  -- Tab bar theme
  {
    'seblj/nvim-tabline',
    event = "TabNew",
    opts = {
      no_name = '[No Name]',    -- Name for buffers with no name
      modified_icon = '',      -- Icon for showing modified buffer
      close_icon = '',         -- Icon for closing tab with mouse
      separator = "▌",          -- Separator icon on the left side
      padding = 3,              -- Prefix and suffix space
      color_all_icons = false,  -- Color devicons in active and inactive tabs
      right_separator = false,  -- Show right separator on the last tab
      show_index = false,       -- Shows the index of tab before filename
      show_icon = true,         -- Shows the devicon
    }
  },
  {
    "lukas-reineke/indent-blankline.nvim",
    event = "BufEnter",
    main = "ibl",
    ---@module "ibl"
    ---@type ibl.config
    opts = {},
  },
  {
    "folke/noice.nvim",
    lazy = false,
    dependencies = {
      "MunifTanjim/nui.nvim",
      "rcarriga/nvim-notify",
    },
  }
}
