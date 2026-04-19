local M = {}
M.plugins = {
  'gh:Aleod-m/konokai',
  'gh:rktjmp/lush.nvim',
  'gh:nvim-lualine/lualine.nvim',
  'gh:seblj/nvim-tabline',
  'gh:lukas-reineke/indent-blankline.nvim',
  'gh:folke/noice.nvim',
  'gh:MunifTanjim/nui.nvim',
}

M.config = function()
  vim.cmd [[ colorscheme konokai ]]

  require'lualine'.setup{
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
            modified="",
            readonly="",
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

  require'tabline'.setup{
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

  require'ibl'.setup{}

  require'noice'.setup{
    lsp = {
      -- override markdown rendering so that **cmp** and other plugins use **Treesitter**
      override = {
        ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
        ["vim.lsp.util.stylize_markdown"] = true,
        ["cmp.entry.get_documentation"] = true, -- requires hrsh7th/nvim-cmp
      },
    },
    -- you can enable a preset for easier configuration
    presets = {
      bottom_search = true, -- use a classic bottom cmdline for search
      command_palette = true, -- position the cmdline and popupmenu together
      long_message_to_split = true, -- long messages will be sent to a split
      inc_rename = false, -- enables an input dialog for inc-rename.nvim
      lsp_doc_border = false, -- add a border to hover docs and signature help
    },
  }
end

return M
