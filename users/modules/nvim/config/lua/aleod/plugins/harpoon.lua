local leader = require('core.keymaps').leader
return {
  'ThePrimeagen/harpoon',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-telescope/telescope.nvim',
  },
  config = function() 
    require('harpoon').setup({})
    local km = require('core.keymaps')
    km.set_keymaps({
      { mode = 'n', keymap = leader 'hh', action = require('harpoon.mark').add_file },
      { mode = 'n', keymap = leader 'hn', action = require('harpoon.ui').nav_next },
      { mode = 'n', keymap = leader 'hp', action = require('harpoon.ui').nav_prev },
      { mode = 'n', keymap = leader 'hu', action = require('harpoon.ui').toggle_quick_menu },
    })
  end,
}
