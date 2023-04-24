--  ╭────┬╮╭──────╮╭───────╮╭─╮ 
--  │ ╭╮ │││ ╭─╮  ││ ╭╮ ╭╮ ││ │ AdrienDML's Neovim config
--  │ ╰╯ │││ │ ╰╮ ││ ││ ││ ││ │ https://github.com/AdrienDML
--  │ ╭╮ │││ │ ╭╯ ││ ││ ││ ││ │ 
--  │ ││ │││ ╰─╯  ││ ││ ││ ││ ╰───╮
--  ╰─╯╰──╯╰──────╯╰─╯╰─╯╰─╯╰─────╯
 
require('utils.globals')
require('options')
require('keymaps')
require('plugins')
require('modes')
require('style')
require('terminal')
require('filetree')
require('complete')
require('git')
require('snip')
require('tele')
require('languages')

require('utils.plugins').finalize()
