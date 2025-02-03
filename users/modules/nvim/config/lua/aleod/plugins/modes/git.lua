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
        color = "amaranth",
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
            gitsigns.toggle_deleted(false)
          end,
      },
      heads = {
        { 'c', function() neogit.open({"commit"}) end, { exit = true } },
        { 'n', function() gitsigns.nav_hunk'next' end, { desc = 'next hunk' } },
        { 'p', function() gitsigns.nav_hunk'prev' end, { desc = 'prev hunk' } },
        { 's', gitsigns.stage_hunk, { nowait = true, desc = 'stage hunk' } },
        { 'u', gitsigns.undo_stage_hunk, { desc = 'undo last stage' } },
        { 'S', gitsigns.stage_buffer, { desc = 'stage buffer' } },
        { 'r', gitsigns.reset_hunk, { desc = 'revert hunk' } },
        { 'd', gitsigns.toggle_deleted, { nowait = true, desc = 'toggle deleted' } },
        { 'b', gitsigns.blame_line, { desc = 'blame' } },
        { 'B', function() gitsigns.blame_line{ full = true } end, { desc = 'blame show full' } },
        { '<Enter>', cmd 'Neogit', { exit = true, desc = 'Neogit' } },
        { '<Esc>', nil, { exit = true, nowait = true, desc = 'exit' } }
      },
    }
  end,
}
