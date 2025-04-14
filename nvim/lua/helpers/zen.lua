M = {}

M.toggle_zen_mode = function()
  vim.g.zen = not vim.g.zen
  vim.o.listchars = not vim.g.zen and 'tab:· ,trail:·,nbsp:+,space:·' or ''
  vim.o.number = not vim.g.zen
  vim.o.relativenumber = not vim.g.zen
  vim.o.spell = not vim.g.zen
  vim.o.colorcolumn = not vim.g.zen and '80' or ''
  -- vim.o.signcolumn = not vim.g.zen and 'yes' or 'no'
  -- vim.diagnostic.enable(not vim.g.zen)
end

return M
