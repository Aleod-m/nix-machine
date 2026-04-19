local M = {}

function M.get(option)
  return vim.opt[option]
end

function M.toggle(option)
  vim.opt[option] = not vim.opt[option]
end

function M.cycle(option, values)
  local current = vim.opt[option]
  local next = 0
  for i, val in ipairs(values) do
    if val == current then
      next = i + 1
      break
    end
  end
  next = next % #values
  vim.o[option] = values[next]
end

function M.get_local(option)
  return vim.opt_local[option]
end

function M.set(option, value)
  if type(option) ~= "table" and value ~= nil then
    vim.opt[option] = value
  elseif type(option) == "table" then
    for k, v in pairs(option) do
      vim.opt[k] = v
    end
  end
end

function M.set_local(option, value)
  if type(option) ~= "table" and value ~= nil then
    vim.opt_local[option] = value
  elseif type(option) == "table" then
    for _, v in pairs(option) do
      vim.opt_local[option] = v
    end
  end
end

-- Set options per filetypes.
local group = vim.api.nvim_create_augroup('FtOpts', { clear = true })
function M.set_for_ft(filetype, option, value)
  -- If no filetype do nothing.
  if filetype == nil then
    return
  end

  if type(filetype) == "table" then
    for _, ft in ipairs(filetype) do
      vim.api.nvim_create_autocmd({ "FileType" }, {
        group = group,
        pattern = ft,
        callback = function()
          M.set_local(option, value)
        end
      })
    end
  elseif type(filetype) == "string" then
    vim.api.nvim_create_autocmd({ "FileType" }, {
      group = group,
      pattern = filetype,
      callback = function()
        M.set_local(option, value)
      end
    })
  end
end

return M
