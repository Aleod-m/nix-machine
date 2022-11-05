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

local M = {}

function M.add_plugin(plugin)
    M.plugins += string
end


packer.init {
  display = {
    open_fn = function()
      return require("packer.util").float { border = "rounded" }
    end,
  },
}



return packer.startup(function (use)
    -- Packer can manage itself
    use ('wbthomason/packer.nvim')
    
    -- Lsp
    use("neovim/nvim-lspconfig")

    -- Completion
    use{
        'hrsh7th/nvim-cmp',
        'hrsh7th/cmp-path',
        'hrsh7th/cmp-buffer',
        'hrsh7th/cmp-nvim-lsp',
        'saadparwaiz1/cmp_luasnip',
    }       

    -- TreeSitter
    use {'nvim-treesitter/nvim-treesitter', opt = true}

    -- Telescope
    use {
      'nvim-telescope/telescope.nvim',
      requires = { {'nvim-lua/plenary.nvim'} }
    }
    
    -- Floating terminal
    use("akinsho/toggleterm.nvim")
    -- Make Telescope pretty
    use ('kyazdani42/nvim-web-devicons')

    -- Rust plugins
    use {
        'cespare/vim-toml',
        'rust-lang/rust.vim',
        'arzg/vim-rust-syntax-ext',
        'simrat39/rust-tools.nvim',
        'saecki/crates.nvim'
    }

    -- Style
    use{
        'nvim-lualine/lualine.nvim',
        'sainnhe/sonokai',
    }

    -- fuzzy finding
    use("junegunn/fzf")
    use("junegunn/fzf.vim")

    -- Snippets
    use("L3MON4D3/LuaSnip")
end)

