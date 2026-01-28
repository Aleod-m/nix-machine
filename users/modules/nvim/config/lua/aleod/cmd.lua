vim.g.testfileResolver = {
  -- Todo make relative to cwd
  java = function()
    return vim.fn.substitute(vim.fn.expand('%:p'), 'main', 'test', '')
  end,
}

vim.api.nvim_create_user_command('Testfile', function(_args)
  if vim.g[vim.bo.filetype] ~= nil then
    local findTestFile = vim.g.testfileResolver[vim.bo.filetype]
    vim.cmd {
      cmd = 'edit',
      args = {'"'..findTestFile()..'"'}
    }
  end
end, {})
