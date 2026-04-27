local log = require"h.log"({title = 'h'})

local M = {}

--- Scans the lua directory and require all the configs
--- if config is { "a", "b" } it will require all the lua files under lua/a/*.lua and lua/b/*.lua
M.load_config = function(configs)

  for _, config in ipairs(configs) do
    local config_root = vim.fn.stdpath('config') .. '/lua/' .. config
    local files  = vim.loop.fs_scandir(config_root)

    if not files then
      log.error("Config not found: " .. config)
      goto continue
    end

    while true do
      local name, typ = vim.loop.fs_scandir_next(files)
      if not name then
        if not typ then
          break -- end of iteration
        else
          log.error("Error while scanning lua files for config:", config)
          goto continue
        end
      end

      if typ == "file" or typ == "link" then
        ---@diagnostic disable-next-line: param-type-mismatch
        local loaded, err = pcall(require, config .. '.' .. vim.split(name, '.', {plain = true})[1])

        if not loaded then
          log.error("Error while loading file", name, "because of", err)
        end
      end

      if typ == "directory" and name == "plugins" then
        require"h.plugin".load_all(config)
      end
    end
    ::continue::
  end
end

return M
