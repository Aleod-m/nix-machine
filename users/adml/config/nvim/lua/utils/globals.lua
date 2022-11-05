-- picked from tj devries config
P = function(v)
  print(vim.inspect(v))
  return v
end

RELOAD = function(...)
  return require("plenary.reload").reload_module(...)
end

R = function(name)
  RELOAD(name)
  return require(name)
end

PREQ = function(...)
    local status, module = pcall(require, ...)
    if (status) then return module end
    local log = require("utils.log")
    log("Module " + ... + " failed loading!")
end
