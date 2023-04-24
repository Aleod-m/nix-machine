local plugins = require("utils.plugins")

plugins.add({
    "folke/trouble.nvim",
    dependencies = {"nvim-tree/nvim-web-devicons"},
})

plugins.add(
    "jose-elias-alvarez/null-ls.nvim"
)

plugins.add({
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    config = function()
        local configs = require("nvim-treesitter.configs")
        configs.setup({
            ensure_installed = {"lua", "rust"},
            sync_install = false,
            ingore_install = {""},
            highlight = {
                enable = true,
                disable = {""},
                additional_vim_regex_highligthing = true,
            },
            indent = {
                enable = true,
            },
        })
    end
})

local languages = {
    rust   = require("languages.settings.rust"),
    --nu     = require("languages.settings.nu"),
    --c      = require("languages.settings.c"),
    --latex  = require("languages.settings.latex"),
    --lua    = require("languages.settings.lua"),
    --elm    = require("languages.settings.elm"),
    --svelte = require("languages.settings.svelte"),
    --wgsl   = require("languages.settings.wgsl"),
    --nix    = require("languages.settings.nix"),
}
