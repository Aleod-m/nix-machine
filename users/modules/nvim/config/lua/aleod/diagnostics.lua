-- local autocmd = require("core.autocmd")("Diagnostics")

vim.diagnostic.config({
  virtual_lines = { current_line = true },
  underline = true,
  signs = {
    text = {
      [vim.diagnostic.severity.HINT] = 'H',
      [vim.diagnostic.severity.INFO] = ' ',
      [vim.diagnostic.severity.WARN] = ' ',
      [vim.diagnostic.severity.ERROR] = ' ',
    }
  }
})
