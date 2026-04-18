local log = require"h.log"
local M = {}

M.source_prefixes = {
  gh = "https://github.com/",
  sh = "https://git.sr.ht/~",
}

--- Wrapper around vim.pack.add that supports prefixes 
--- such as "gh:User/Repo" -> "https://github.com/User/Repo"
function M.add(specs)
  specs = vim.tbl_map(M.__map_specs, specs)
  vim.pack.add(specs)
end

-- Load plugins for a plugins directory.
-- [config]/lua/[user]/plugins/**
function M.load_all(user)
  local modul
end

function load_module(spec)
end

function M.__map_specs(spec)
  if type(spec) == "string" then
    local url = M.get_url(spec)
    vim.pack.add(url)
  elseif type(spec) == "table" then
    if spec.src == nil then
      log.error("[plugin] Spec has no src field.")
    end
    spec.src = M.get_url(spec.src)
    vim.pack.add(spec)
  end
end

function M.__find_modules(user)
  local root = vim.fn.stdpath('config') .. '/lua/' .. user .. '/plugins'
  if vim.loop.fs_stat(root) == nil then
    log.error('No plugin dir found for user: ' .. user)
    return
  end
end

function M.__extract_config(spec)
  
end



function M.__get_url(prefix_url)
  if vim.startswith(prefix_url, "https") then return prefix_url end
  local components = vim.split(prefix_url, ':', {plain = true, trimempty = true})
  local prefix = components[1]
  table.remove(components, 1)
  if M.source_prefixes[prefix] == nil then
    log.error("[plugin] Unknown soure: ", components[0])
  end

  return M.source_prefixes[components[0]] .. table.concat({components}, ":")
end


return M
