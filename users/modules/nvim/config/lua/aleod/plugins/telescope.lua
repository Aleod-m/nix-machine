local M = {}
M.plugins = {
  'gh:nvim-telescope/telescope.nvim',
  'gh:nvim-lua/plenary.nvim',
  'gh:nvim-telescope/telescope-ui-select.nvim',
  'gh:nvim-telescope/telescope-live-grep-args.nvim',
}

M.config = function()
  local tele = require('telescope')
  tele.setup({
    extensions = {
      ['ui-select'] = {
        require('telescope.themes').get_dropdown { }
      },
      live_grep_args = {}
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
  tele.load_extension('live_grep_args')
  tele.load_extension('ui-select')
  
  local km = require'h.keymaps'
  local leader = km.leader
  local cmd = km.cmd
  km.set_keymaps({
    { mode= 'n', keymap=leader 'ff',  action=require('telescope.builtin').find_files  },
    { mode= 'n', keymap=leader 'fs',  action=require('telescope.builtin').lsp_dynamic_workspace_symbols},
    { mode= 'n', keymap=leader 'fgs', action=cmd "lua require('telescope').extensions.live_grep_args.live_grep_args()" },
    { mode= 'n', keymap=leader 'fgf', action=require('telescope.builtin').git_files   },
    { mode= 'n', keymap=leader 'fgb', action=require('telescope.builtin').git_branches},
    { mode= 'n', keymap=leader 'fb',  action=require('telescope.builtin').buffers     },
    { mode= 'n', keymap=leader 'dl',  action=require('telescope.builtin').diagnostics },
    { mode= 'n', keymap='z=',  action=require('telescope.builtin').spell_suggest },
  })
end

return M
