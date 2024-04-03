return { {
  'nvim-treesitter/nvim-treesitter',
  event = { "BufReadPre", "BufNewFile" },
  build = ':TSUpdate',
  config = function()
    local configs = require("nvim-treesitter.configs")
    configs.setup({
      highlight = {
        enable = true,
        disable = {""},
      },

      indent = { enable = true, },
      ensure_installed = {
        -- Noice
        "vim",
        "regex",
        "markdown",
        "markdown_inline",

        -- Programming languages.
        "rust",
        "nix",
        "lua",
        "c",
        "cpp",
        "bash",
        "zig",
        "python",
        "sql",
        "wgsl",
        "wgsl_bevy",

        -- Web.
        "html",
        "css",
        "scss",
        "javascript",
        "typescript",

        -- Data formats.
        "toml",
        "xml",
        "json",
        "yaml",
      },
    })

    local parser_config = require "nvim-treesitter.parsers".get_parser_configs()
    parser_config.wgsl = {
      install_info = {
        url = "szebniok/tree-sitter-wgsl",
        files = {"src/parser.c"},
        branch = "main",
      },
      filetype = "wgsl"
    }
    parser_config.just = {
      install_info = {
        url = "https://github.com/IndianBoy42/tree-sitter-just",
        files = { "src/parser.c", "src/scanner.cc" },
        branch = "main",
      },
      filetype = "justfile"
    }
  end
}, {
  "nushell/tree-sitter-nu",
  build = ":TSUpdate",
  dependencies = { 
    'nvim-treesitter/nvim-treesitter',
  },
} }
