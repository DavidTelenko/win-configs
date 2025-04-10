-- Highlight on yank
vim.api.nvim_create_autocmd('TextYankPost', {
  callback = function()
    vim.hl.on_yank { timeout = 200 }
  end,
  group = vim.api.nvim_create_augroup('YankHighlight', {
    clear = true,
  }),
  pattern = '*',
})

-- netrw keymaps for more 'lettered' experience
vim.api.nvim_create_autocmd('BufModifiedSet', {
  group = vim.api.nvim_create_augroup('Netrw', {
    clear = true,
  }),
  pattern = '*',
  callback = function()
    if not (vim.bo and vim.bo.filetype == 'netrw') then
      return
    end
    vim.keymap.set('n', 'l', '<cr>', { buffer = true, remap = true })
    vim.keymap.set('n', 'h', '-', { buffer = true, remap = true })
    vim.keymap.set('n', 'a', '%', { buffer = true, remap = true })
    vim.keymap.set('n', '<F1>', '<Esc>', { buffer = true, remap = true })
  end,
})

-- Clear redundant spaces at the end of lines
vim.api.nvim_create_autocmd({ 'BufWritePre' }, {
  group = vim.api.nvim_create_augroup('ClearPostSpaces', { clear = true }),
  pattern = '*',
  command = [[%s/\s\+$//e]],
})

-- Disable some options in terminal mode
vim.api.nvim_create_autocmd('TermOpen', {
  group = vim.api.nvim_create_augroup('TerminalMode', { clear = true }),
  pattern = '*',
  callback = function()
    vim.o.spell = false
    vim.wo.signcolumn = 'yes'
  end,
})

-- Muscle memory
vim.api.nvim_create_user_command('E', function()
  -- vim.cmd 'Explore'
  -- vim.cmd 'Oil'
end, {})

-- Toggle Quickfix list
vim.api.nvim_create_user_command('ToggleQuickfix', function()
  local qf_exists = false
  for _, win in pairs(vim.fn.getwininfo()) do
    if win['quickfix'] == 1 then
      qf_exists = true
    end
  end
  if qf_exists then
    vim.cmd 'cclose'
    return
  end
  if not vim.tbl_isempty(vim.fn.getqflist()) then
    vim.cmd 'copen'
  else
    print 'Quickfix list is empty'
  end
end, {})

vim.keymap.set('n', '<leader>q', function()
  vim.cmd 'ToggleQuickfix'
end, { noremap = true, silent = true, desc = 'Toggle quickfix' })
