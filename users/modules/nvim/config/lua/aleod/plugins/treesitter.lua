local M = {}
M.plugins = {
  'gh:nvim-treesitter/nvim-treesitter',
  'gh:tadmccorkle/markdown.nvim',
}

M.config = function()
  local au = require("h.autocmd")("TS")
  local log = require("h.log")()
  au('FileType', {
    callback = function()
      if not pcall(vim.treesitter.start) then
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
return M
