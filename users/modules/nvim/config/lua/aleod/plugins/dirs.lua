local cmd = require'core.cmd'
return { 
  {
    'stevearc/oil.nvim',
    lazy = false,

    -- Optional dependencies
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    keys = {
      {mode= 'n', '-',  cmd 'Oil' },
    },
    config = true,
  }, {
    'natecraddock/workspaces.nvim',
    lazy = false,

    dependencies = {
      'nvim-telescope/telescope.nvim',
      'stevearc/oil.nvim',
    },

    config = function()
      require('workspaces').setup({
        hooks = {
          open = 'Oil .',
        }
      })
      require('telescope').load_extension('workspaces')
      local group = vim.api.nvim_create_augroup('AleodConfig', {clear = false})
      vim.api.nvim_create_autocmd({"UIEnter"}, {
        group = group,
        callback = function(args) 
          if #(vim.v.argv) == 4 then
            vim.cmd[[Telescope workspaces]]
          end
        end
      })

    end
  },
}
