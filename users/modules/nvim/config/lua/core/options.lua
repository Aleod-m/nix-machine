local M = {}

function M.get(option)
  return vim.opt[option]
end

function M.get_local(option)
  return vim.opt_local[option]
end

function M.set(option, value)
  if type(option) ~= "table" and value ~= nil then
    vim.o[option] = value
  elseif type(option) == "table" then
    for k, v in pairs(option) do
      vim.o[k] = v
    end
  end
end

function M.set_local(option, value)
  if type(option) ~= "table" and value ~= nil then
    vim.bo[option] = value
  elseif type(option) ~= "table" then
    for k, v in pairs(option) do
      vim.bo[option] = v
    end
  end
end

-- Set options per filetypes.
local group = vim.api.nvim_create_augroup('FtOpts', {clear = true})
function M.set_for_ft(ft, option, value)
  -- If no filetype do nothing.
  if ft == nil then
    return
  end

  if type(ft) == "table" then 
    for _, ft in ipairs(ft) do
      vim.api.nvim_create_autocmd({"FileType"}, {
        group = group,
        pattern = ft,
        callback = function(args)
          M.set_local(option, value)
        end
      })
    end
  elseif type(ft) == "string" then
    vim.api.nvim_create_autocmd({"FileType"}, {
      group = group,
      pattern = ft,
      callback = function(args)
        for k, v in pairs(options) do 
          M.set_local(option, value)
        end
      end
    })
  end
end

return M
