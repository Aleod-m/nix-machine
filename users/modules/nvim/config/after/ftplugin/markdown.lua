vim.wo.foldmethod = 'expr'
vim.wo.foldexpr = 'v:lua.mdfoldexpr()'
function _G.mdfoldexpr()
  local heading = vim.fn.getline(vim.v.lnum):match('^(#+)%s')
  if heading then
    local lvl = #heading
    if lvl == 1 then
      return ">1"
    elseif lvl >= 2 and lvl <= 6 then
      return ">" ..lvl
    end
  end
  return "="
end
