local km = require('core.keymaps')
local leader = km.leader
local alt = km.alt

return {
  "ThePrimeagen/harpoon",
  branch = "harpoon2",
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-telescope/telescope.nvim',
  },
  config = function()
    local harp = require('harpoon')
    harp:setup()
    km.set_keymaps({
      { mode = 'n', keymap = leader 'ha', action = function() harp:list():add() end },
      { mode = 'n', keymap = leader 'hn', action = function() harp:list():next() end },
      { mode = 'n', keymap = leader 'hp', action = function() harp:list():prev() end },
      { mode = 'n', keymap = alt 'n', action = function() harp:list():select(1) end },
      { mode = 'n', keymap = alt 'e', action = function() harp:list():select(2) end },
      { mode = 'n', keymap = alt 'o', action = function() harp:list():select(3) end },
      { mode = 'n', keymap = alt 'i', action = function() harp:list():select(4) end },
      { mode = 'n', keymap = leader 'hf', action = function() harp.ui:toggle_quick_menu(harp:list()) end},
   })
  end,
}
