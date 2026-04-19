-- Todo setup kitty splits & integration with smart-splits.
return {
  dependencies = {
    'gh:nvim-telescope/telescope.nvim',
    'gh:mrjones2014/smart-splits.nvim',
  },
  mode = function()
    local ss = require("smart-splits")
    local km = require 'h.keymaps'
    local ctrl = km.ctrl
    local cmd = km.cmd
    local trycmd = km.trycmd
    return {
      name = "Test",
      mode = "n",
      body = "<Leader>s",
      config = {
        hint = false,
        timeout = false,
        invoke_on_body = true,
      },
      heads = {
        -- Move arround Splits
        { "h", ss.move_cursor_left },
        { "t", ss.move_cursor_up },
        { "k", ss.move_cursor_down },
        { "l", ss.move_cursor_right },

        -- Move Splits arround
        { "H", function() ss.swap_buf_left() end },
        { "T", function() ss.swap_buf_up() end },
        { "K", function() ss.swap_buf_down() end },
        { "L", function() ss.swap_buf_right() end },

        -- Resize splits
        { '=',      ctrl 'w' .. '=' },
        { ctrl 'h', function() ss.resize_left() end },
        { ctrl 'k', function() ss.resize_down() end },
        { ctrl 't', function() ss.resize_up() end },
        { ctrl 'l', function() ss.resize_right() end },
        --
        -- Create and close splits
        { 's', ctrl 'w' .. 's' },
        { 'v', ctrl 'w' .. 'v' },
        { "q", trycmd 'close' },
        { "w", trycmd 'w' },

        -- Change current split.
        { "b", require 'telescope.builtin'.buffers,    { exit = true } },
        { "F", require 'telescope.builtin'.find_files, { exit = true } },

        -- Manage Tabs
        { 'n', cmd 'tabn' },
        { 'p', cmd 'tabp' },
        { 'N', trycmd 'tabm +' },
        { 'P', trycmd 'tabm -' },
        { 'Q', trycmd 'tabc' },
        { 'O', cmd 'tabnew' },

        { '<Esc>',  nil, { exit = true, nowait = true, desc = 'exit' } }
      }
    }
  end,
}
