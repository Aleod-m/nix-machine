local PLUGIN_DIR = "~/.local/share/nvim/plug"

local download_packer = function()
    if vim.fn.input "Download Packer? (y for yes)" ~= "y" then
        return
    end

    local directory = string.format("%s/site/pack/packer/start/", vim.fn.stdpath "data")

    vim.fn.mkdir(directory, "p")

    local out = vim.fn.system(
        string.format("git clone %s %s", "https://github.com/wbthomason/packer.nvim", directory .. "/packer.nvim")
    )

    print(out)
    vim.cmd [[packadd packer.nvim]]

    print "Downloading packer.nvim..."
    print "( You'll need to restart now )"
end


local packer_status, packer = pcall(require, "packer")
if not packer_status then
    download_packer()
    return true
end

packer.init {
  display = {
    open_fn = function()
      return require("packer.util").float { border = "rounded" }
    end,
  },
}

-- Sync plugins on save of this file
vim.cmd [[
    augroup packer_cfg
        autocmd!
        autocmd BufWritePost plugins.lua source <afile> | PackerSync
    augroup end
]]

local use = packer.use
return packer.startup(function ()
    -- Packer can manage itself
    use ('wbthomason/packer.nvim')
    
    -- Lsp
    use("neovim/nvim-lspconfig")

    -- Git
    -- use { 'TimUntersberger/neogit', requires = 'nvim-lua/plenary.nvim' }
    use { 'lewis6991/gitsigns.nvim' }

    -- Terminal
    use {"akinsho/toggleterm.nvim", tag="v2.*"}

    -- Utils
    use("RRethy/nvim-align")
    use { 'anuvyklack/hydra.nvim', 
        requires = 'anuvyklack/keymap-layer.nvim' -- needed only for pink hydras
    }
    use('sindrets/winshift.nvim')
    use('mrjones2014/smart-splits.nvim')

    -- Completion
    use('hrsh7th/nvim-cmp')
    use('hrsh7th/cmp-path')
    use('hrsh7th/cmp-buffer')
    use('hrsh7th/cmp-nvim-lsp')
    use('saadparwaiz1/cmp_luasnip')

    -- NeoTree
    use {
      'kyazdani42/nvim-tree.lua',
      requires = {
        'kyazdani42/nvim-web-devicons', -- optional, for file icons
      },
      tag = 'nightly' -- optional, updated every week. (see issue #1193)
    }
   
    -- TreeSitter
    use {
        'nvim-treesitter/nvim-treesitter',
        run = ':TSUpdate'
    }

    -- Telescope
    use {
      'nvim-telescope/telescope.nvim',
      requires = { {'nvim-lua/plenary.nvim'} }
    }
    use { "nvim-telescope/telescope-file-browser.nvim" }
    use ('nvim-telescope/telescope-ui-select.nvim')

    -- Make Telescope pretty
    use ('kyazdani42/nvim-web-devicons')

    -- Style
    use{
        'nvim-lualine/lualine.nvim',
        'seblj/nvim-tabline',
        'sainnhe/sonokai',
        'glepnir/dashboard-nvim',
    }

    -- Snippets
    use("L3MON4D3/LuaSnip")

    -- Latex
    use('lervag/vimtex')

    -- Rust plugins
    use {
        'rust-lang/rust.vim',
        'simrat39/rust-tools.nvim',
        {
        'saecki/crates.nvim',
        config=function ()
            require"crates".setup()
        end,
        }
    }

    use {
        'LhKipp/nvim-nu',
        run = ":TSInstall nu"
    }

    -- discord
    use 'andweeb/presence.nvim'

    -- Java plugins
    use {
        "mfussenegger/nvim-jdtls",
        "uiiaoo/java-syntax.vim",
    }
end)
