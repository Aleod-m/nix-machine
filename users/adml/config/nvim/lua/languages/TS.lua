local configs = require"nvim-treesitter.configs"

configs.setup {
    ensure_installed = "all",
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
}
