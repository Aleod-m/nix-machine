local plugins = require("utils.plugins")

local M = {
    rust   = require("languages.settings.rust"),
    wgsl   = require("languages.settings.wgsl"),
    lua    = require("languages.settings.lua"),
    nix    = require("languages.settings.nix"),
    zig    = require("languages.settings.zig"),
    --nu     = require("languages.settings.nu"),
    --c      = require("languages.settings.c"),
    --latex  = require("languages.settings.latex"),
    --elm    = require("languages.settings.elm"),
    --svelte = require("languages.settings.svelte"),
}

plugins.add({
    "folke/trouble.nvim",
    dependencies = {"nvim-tree/nvim-web-devicons"},
})

plugins.add(
    "jose-elias-alvarez/null-ls.nvim"
)

-- Config TreeSitter
plugins.add({
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    config = function()
        local install = {}
        for _, lang in ipairs(M) do
            local lname = lang.setup_TS()
            if lname ~= nil then
                install[#ensure_installed] = lname
            end
        end

        local configs = require("nvim-treesitter.configs")
        configs.setup({
            ensure_installed = install,
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

return M
