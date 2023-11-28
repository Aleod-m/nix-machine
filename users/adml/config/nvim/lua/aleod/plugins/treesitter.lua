return {
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
        -- Main languages.
        "rust",
        "nix",
        "lua",
        --"Godot",

        -- Secondary languages.
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

        -- Data formats.
        "toml",
        "xml",
        "json",
        "yaml",
      },
    })

    local parser_config = require "nvim-treesitter.parsers".get_parser_configs()
    parser_config.nu = {
      install_info = {
        url = "https://github.com/nushell/tree-sitter-nu",
        files = { "src/parser.c" },
        branch = "main",
      },
      filetype = "nu",
    }
    parser_config.wgsl = {
      install_info = {
        url = "szebniok/tree-sitter-wgsl",
        files = {"src/parser.c"}
      },
      filetype = "wgsl"
    }
    parser_config.just = {
      install_info = {
        url = "https://github.com/IndianBoy42/tree-sitter-just",
        files = { "src/parser.c", "src/scanner.c" },
        branch = "main",
      },
      filetype = "justfile"
    }
  end
}
