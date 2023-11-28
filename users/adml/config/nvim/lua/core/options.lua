local M = {}
local group = vim.api.nvim_create_augroup('FtOpts', {clear = true})

function M.set(option, value)
  vim.o[option] = value
end

function M.set_many(options)
  if type(options) ~= "table" then
    return
  end
  for k, v in pairs(options) do
    vim.o[k] = v
  end
end

function M.set_local(option, value)
  vim.bo[option] = value
end

function M.set_many_local(options)
  if type(options) ~= "table" then
    return
  end

  for k, v in pairs(options) do
    vim.bo[k] = v
  end
end

-- Set options per filetypes.
function M.set_for_ft(ft, options)
  -- If opts is not table 
  if type(options) ~= "table" or ft == nil then
    return
  end

  if type(ft) == "table" then 
    for _, ft in ipairs(ft) do
      vim.api.nvim_create_autocmd({"FileType"}, {
        group = group,
        pattern = ft,
        callback = function(args)
          for k, v in pairs(option) do 
            vim.bo[k] = v
          end
        end
      })
    end
  elseif type(ft) == "string" then
    vim.api.nvim_create_autocmd({"FileType"}, {
      group = group,
      pattern = ft,
      callback = function(args)
        for k, v in pairs(option) do 
          vim.bo[k] = v
        end
      end
    })
  end
end

return M
