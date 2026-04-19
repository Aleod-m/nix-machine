local logger = {}

logger.level = vim.log.levels.OFF
logger.opts = {}

return setmetatable({},  {
  __call = function(_, opts)
    if opts ~= nil then
      logger.opts = opts
    end
    return setmetatable(logger, {
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
          return logger[index]
        end
        return logger
      end,
      __call = function(self, ...)
        vim.notify(table.concat({...}, " "), self.level, self.opts)
      end
    })
  end
})
