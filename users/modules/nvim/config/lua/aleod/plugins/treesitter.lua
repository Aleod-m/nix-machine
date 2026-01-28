return {
  {
    'nvim-treesitter/nvim-treesitter',
    dependencies = {
      "tadmccorkle/markdown.nvim",
    },
    event = { "BufReadPre", "BufNewFile" },
    build = ':TSUpdate',
    config = function()
      local configs = require("nvim-treesitter.configs")
      ---@type table<string, any>
      local parser_config = require("nvim-treesitter.parsers").get_parser_configs()
      parser_config.ebnf = {
        install_info = {
          url = 'https://github.com/Aleod-m/tree-sitter-ebnf', -- local path or git repo
          files = { 'src/parser.c' },
          queries = 'queries',
        },
        filetype = "ebnf", -- if filetype does not match the parser name
      }
      vim.treesitter.language.register("ebnf", "ebnf")
      ---@diagnostic disable-next-line: missing-fields
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

          "php",
          "perl",

          -- Programming languages.
          "rust",
          "nix",
          "lua",
          "luadoc",
          "c",
          "cpp",
          "bash",
          "zig",
          "python",
          "sql",
          "wgsl",
          "wgsl_bevy",
          "java",
          "javadoc",

          -- Web.
          "html",
          "angular",
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
    end
  },
  {
    "aleod-m/tree-sitter-ebnf",
    build = ":TSUpdate",
    dependencies = {
      'nvim-treesitter/nvim-treesitter',
    },
  }
}
