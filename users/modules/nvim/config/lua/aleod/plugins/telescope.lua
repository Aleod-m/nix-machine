local leader = require('core.keymaps').leader
return {
  'nvim-telescope/telescope.nvim',
  lazy = false,
  dependencies = { 
    'nvim-lua/plenary.nvim',
    'nvim-telescope/telescope-ui-select.nvim',
    "nvim-telescope/telescope-live-grep-args.nvim" ,
  },
  keys = {
    { mode= 'n', leader 'ff',  require('telescope.builtin').find_files  },
    { mode= 'n', leader 'fs',  require('telescope.builtin').lsp_dynamic_workspace_symbols},
    { mode= 'n', leader 'fgs',  require('telescope').extensions.live_grep_args.live_grep_args },
    { mode= 'n', leader 'fgf', require('telescope.builtin').git_files   },
    { mode= 'n', leader 'fgb', require('telescope.builtin').git_branches},
    { mode= 'n', leader 'fb',  require('telescope.builtin').buffers     },
    { mode= 'n', leader 'dl',  require('telescope.builtin').diagnostics },
  },
  config = function() 
    local tele = require('telescope')
    tele.setup({
      extensions = {
        ['ui-select'] = {
          require('telescope.themes').get_dropdown { }
        },
      },
      pickers = {
        current_buffer_fuzzy_find = {
          sorting_strategy = 'ascending',
          prompt_position = 'top',
        },
      },
      defaults = {
        prompt_prefix = ' ',
      },
    })
    tele.load_extension('ui-select')
    tele.load_extension('telescope-live-grep-args')
  end,
}
