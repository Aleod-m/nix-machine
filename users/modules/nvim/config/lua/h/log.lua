local M = {}

M.level = vim.log.levels.OFF

return setmetatable(M, {
  __index = function(self, index)
    if index == "error" then
      self.level = vim.log.levels.ERROR
    elseif index == "info" then
      self.level = vim.log.levels.INFO
    elseif index == "warn" then
      self.level = vim.log.levels.WARN
    elseif index == "trace" then
      self.level = vim.log.levels.TRACE
    elseif index == "debug" then
      self.level = vim.log.levels.DEBUG
    else
      return M[index]
    end
    return M
  end,
  __call = function(_, ...)
    vim.notify(table.concat({...}, " "), M.level)
  end
})
