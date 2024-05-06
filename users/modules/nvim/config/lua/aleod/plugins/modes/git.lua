return {
  dependencies = {
    'TimUntersberger/neogit',
    'lewis6991/gitsigns.nvim',
  },
  keys = {"<Space>g"},
  config = function()
    local gitsigns = require'gitsigns'
    local neogit = require'neogit'
    require('hydra')({
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
        { 'n', gitsigns.next_hunk, { desc = 'next hunk' } },
        { 'p', gitsigns.prev_hunk, { desc = 'prev hunk' } },
        { 's', gitsigns.stage_hunk, { nowait = true, desc = 'stage hunk' } },
        { 'u', gitsigns.undo_stage_hunk, { desc = 'undo last stage' } },
        { 'S', gitsigns.stage_buffer, { desc = 'stage buffer' } },
        { 'r', gitsigns.revert_hunk, { desc = 'revert hunk' } },
        { 'd', gitsigns.toggle_deleted, { nowait = true, desc = 'toggle deleted' } },
        { 'b', gitsigns.blame_line, { desc = 'blame' } },
        { 'B', function() gitsigns.blame_line{ full = true } end, { desc = 'blame show full' } },
        { '<Enter>', '<Cmd>Neogit<CR>', { exit = true, desc = 'Neogit' } },
        { '<Esc>', nil, { exit = true, nowait = true, desc = 'exit' } }
      }
    })
  end
}
