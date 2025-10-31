-- local autocmd = require("core.autocmd")("Diagnostics")

vim.diagnostic.config({
  virtual_lines = { current_line = true },
  underline = true,
})
