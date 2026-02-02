return {
  hint = {
    funcs = {},
  },
  keys = { "<Space>to" },
  mode = function()
    local cmd = require('core.cmd')
    local opt = require('core.options')

    return {
      name = "Toggle Options",
      mode = { "n", "x" },
      body = "<Leader>to",
      config = {
        hint = {
          position = 'middle',
          float_opts = {
            border = 'rounded'
          },
        },
        color = 'amaranth',
        timeout = false,
        invoke_on_body = true,
      },
      hint = [[
  ^ ^        Options
  ^
  _v_ %{ve} virtual edit
  _i_ %{list} invisible characters
  _s_ %{spell} spell
  _c_ %{cul} cursor line
  _n_ %{nu} number
  _r_ %{rnu} relative number
  ^
  ^^^^                _<Esc>_
]],
      heads = {
        { 'n',     function() opt.toggle('number') end,                         { desc = 'number' } },
        { 'r',     function() opt.toggle('relativenumber') end,                 { desc = 'relativenumber' } },
        { 'v',     function() opt.cycle('virtualedit', { 'all', 'block' }) end, { desc = 'virtualedit' } },
        { 'i',     function() opt.toggle('list') end,                           { desc = 'show invisible' } },
        { 's',     function() opt.toggle('spell') end,                          { exit = true, desc = 'spell' } },
        { 'c',     function() opt.toggle('cursorline') end,                     { desc = 'cursor line' } },
        { '<Esc>', nil,                                                         { exit = true } }
      },
    }
  end,
}
