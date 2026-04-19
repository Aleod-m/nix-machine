local cmd = require'h.cmd'

vim.g.testfileResolver = {
  -- Todo make relative to cwd
  java = function()
    return vim.fn.substitute(vim.fn.expand('%:p'), 'main', 'test', '')
  end,
}

cmd.create('Testfile', function(_)
  if vim.g[vim.bo.filetype] ~= nil then
    local resolver = vim.g.testfileResolver[vim.bo.filetype]
    cmd {
      cmd = 'edit',
      args = {'"'..resolver()..'"' }
    }
  end
end, {})
