local log = require"h.log"({title = 'h.plugin'})
local M = {}

M.source_prefixes = {
  gh = "https://github.com/",
  sh = "https://git.sr.ht/~",
}

--- Wrapper around vim.pack.add that supports prefixes 
--- such as "gh:User/Repo" -> "https://github.com/User/Repo"
function M.add(specs)
  local pack_specs = vim.tbl_map(M.__map_pack_specs, specs)
  vim.pack.add(pack_specs)
end

-- Load plugins for a plugins directory.
-- [config]/lua/[user]/plugins/**
function M.load_all(path)
  local modules = M.__find_modules(path)

  -- Get all the specs defined for the enabled modules.
  local module_pack_specs = vim.iter(modules)
    :filter(function(it) return it.disabled or true end)
    :map(function(it) return it.plugins or {} end)
    :flatten()
    :unique()
    :totable()

  M.add(module_pack_specs)

  for _, mod in ipairs(modules) do
    if mod.config then
      mod.config()
    end
  end
end

function M.__find_modules(user)
  local root = vim.fn.stdpath('config') .. '/lua/' .. user .. '/plugins'
  local files = vim.loop.fs_scandir(root)
  local loaded_modules = {}

  if not files then
    log.error('No plugin dir found for user: ' .. user)
    return {}
  end

  local root_loaded, root_module = pcall(require, user ..'.plugins')
  if root_loaded then
    loaded_modules[#loaded_modules+1] = root_module
  end

  while true do
    local name, typ = vim.loop.fs_scandir_next(files)
    if not name then
      if not typ then
        break -- exit cond
      else
        log.error("Error scanning for plugin files [", typ , "] for user:", user)
      end
    end

    ---@diagnostic disable-next-line: param-type-mismatch
    local loaded, module_or_err = pcall(require, user ..'.plugins.' .. vim.split(name, '.', {plain = true})[1])

    if not loaded then
      log.error("Error when loading", name, "plugin module for user", user, module_or_err)
      goto continue
    end

    loaded_modules[#loaded_modules+1] = module_or_err

    ::continue::
  end

  return loaded_modules
end

function M.__map_pack_specs(spec)
  if type(spec) == "string" then
    return M.__get_url(spec)
  elseif type(spec) == "table" then
    if spec.src == nil then
      log.error("[plugin] Spec has no src field.")
    end
    spec.src = M.get_url(spec.src)
    return spec
  end
end

function M.__get_url(prefix_url)
  log.debug("url", prefix_url)
  if vim.startswith(prefix_url, "https") then return prefix_url end
  local components = vim.split(prefix_url, ':', {plain = true, trimempty = true})
  local prefix = table.remove(components, 1)
  log.debug("prefix", prefix)

  if not M.source_prefixes[prefix] then
    log.error("[plugin] Unknown soure: ", prefix)
  end

  print(vim.inspect(components))
  return M.source_prefixes[prefix] .. table.concat(components, ":")
end


return M
