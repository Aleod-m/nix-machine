return { {
  'nvim-treesitter/nvim-treesitter',
  dependencies = {
    "tadmccorkle/markdown.nvim",
  },
  event = { "BufReadPre", "BufNewFile" },
  build = ':TSUpdate',
  config = function()
    local configs = require("nvim-treesitter.configs")
    configs.setup({
      highlight = {
        enable = true,
        disable = {""},
      },
      markdown = { enable = true, },

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
        "java",

        -- Web.
        "html",
        "css",
        "scss",
        "javascript",
        "typescript",

        -- Godot.
        "gdscript",
        -- "gdresource", Causes an error for some reason.
        "gdshader",

        -- Data formats.
        "toml",
        "xml",
        "json",
        "yaml",
      },
    })

    ---@class ParserInfo[]
    local parser_config = require "nvim-treesitter.parsers".get_parser_configs()
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
