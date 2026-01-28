return {
  dependencies = {
    'TimUntersberger/neogit',
    'lewis6991/gitsigns.nvim',
  },
  keys = { "<Space>g" },
  mode = function()
    local gitsigns = require('gitsigns')
    local cmd = require('core.cmd')
    local neogit = require('neogit')
    return {
      name = "Git",
      mode = 'n',
      body = '<leader>g',
      config = {
        color = "pink",
        hint = false,
        invoke_on_body = true,
        on_key = function() vim.wait(50) end,
        on_enter = function()
          vim.cmd 'mkview'
          vim.cmd 'silent! %foldopen!'
          vim.bo.modifiable = false
        end,
        on_exit = function()
          local cursor_pos = vim.api.nvim_win_get_cursor(0)
          vim.cmd 'loadview'
          vim.api.nvim_win_set_cursor(0, cursor_pos)
          vim.cmd 'normal zv'
        end,
      },
      heads = {
        {
          'n',
          function()
            gitsigns.nav_hunk('next')
          end,
          { desc = 'next hunk' }
        },
        {
          'N',
          function()
            gitsigns.nav_hunk('prev')
          end,
          { desc = 'prev hunk' }
        },
        { 'p',       gitsigns.preview_hunk_inline,                       { desc = 'preview' } },
        { 's',       gitsigns.stage_hunk,                                { nowait = true, desc = 'stage hunk' } },
        { 'u',       gitsigns.stage_hunk,                                { desc = 'undo last stage' } },
        { 'S',       gitsigns.stage_buffer,                              { desc = 'stage buffer' } },
        { 'r',       gitsigns.reset_hunk,                                { desc = 'revert hunk' } },
        { 'b',       gitsigns.blame_line,                                { desc = 'blame' } },
        { 'B',       function() gitsigns.blame_line { full = true } end, { desc = 'blame show full' } },
        { 'w',       function() neogit.action('worktree', 'visit') end,  { desc = 'changes worktree' } },
        { '/',       gitsigns.show,                                      { exit = true, desc = 'show base file' } }, -- show the base of the file
        { 'c',       function() neogit.open({ "commit" }) end,           { exit = true, desc = 'commit' } },
        { '<Enter>', cmd 'Neogit',                                       { exit = true, desc = 'Neogit' } },
        { '<Esc>',   nil,                                                { exit = true, nowait = true, desc = 'exit' } }
      },
    }
  end,
}
