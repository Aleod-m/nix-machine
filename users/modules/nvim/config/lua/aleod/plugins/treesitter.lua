local au = require("core.autocmd")("TS")
---@type LazySpec
return {
  {
    'nvim-treesitter/nvim-treesitter',
    branch = "main",
    dependencies = {
      "tadmccorkle/markdown.nvim",
    },
    event = { "BufReadPre", "BufNewFile" },
    build = ':TSUpdate',
    config = function() 
      au('FileType', {
        callback = function()
          if not pcall(vim.treesitter.start) then
            -- TODO warn if ts failed for file type
            return
          end
          vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
        end,
      })
      local ensureInstalled = {
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
      }
      local alreadyInstalled = require('nvim-treesitter.config').get_installed()
      local parsersToInstall = vim.iter(ensureInstalled)
        :filter(function(parser)
          return not vim.tbl_contains(alreadyInstalled, parser)
        end)
        :totable()
      require('nvim-treesitter').install(parsersToInstall)
    end
  },
}
