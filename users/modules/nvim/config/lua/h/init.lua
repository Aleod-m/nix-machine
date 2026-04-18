local log = require"h.log"

local M = {}

--- Scans the lua directory and require all the configs
--- if config is { "a", "b" } it will require all the lua files under lua/a/*.lua and lua/b/*.lua
M.load_configs = function(configs)
  for _, config in ipairs(configs) do
    local files  = vim.loop.fs_scandir(vim.fn.stdpath('config')..'/lua/'.. config)
    if not files then
      log.error("Config not found: " .. config)
      goto continue
    end

    while true do
      local name, typ = vim.loop.fs_scandir_next(files)
      if not name then
        log.error("Error while scanning lua files for config: " .. config)
      end
      if typ == "file" then
        pcall(require, name)
      end

    end
    ::continue::
  end
end

return M
