-- Keymaps for better default experience
vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', {
  silent = true,
})

vim.keymap.set({ 'n', 'i', 'v' }, '<F1>', '<Esc>', {
  silent = true,
})

vim.keymap.set('v', 'J', ":m '>+1<CR>gv=gv", {
  desc = 'Move selection down',
})

vim.keymap.set({ 'v', 'n' }, 'Z', 'J', {
  desc = 'Join lines',
})

vim.keymap.set('v', 'K', ":m '<-2<CR>gv=gv", {
  desc = 'Move selection up',
})

vim.keymap.set('n', 'J', 'mzJ`z')

-- L and H - begin and end of the line
vim.keymap.set({ 'n', 'v' }, 'L', '$')
vim.keymap.set({ 'n', 'v' }, 'H', '_')

-- Jump to begin end of a tag
vim.keymap.set('n', ']t', 'vat<esc>', { desc = 'Next tag' })
vim.keymap.set('n', '[t', 'vato<esc>', { desc = 'Prev tag' })

-- Disable default control keymaps
vim.keymap.set('i', '<C-k>', '<NOP>', {})
vim.keymap.set('i', '<C-j>', '<NOP>', {})

-- Paste without reyanking
-- vim.keymap.set('v', 'p', '"0p')
vim.keymap.set('v', 'p', 'P', {
  desc = 'Paste without copying selected text in visual mode',
})

-- Scrolling with stabilization
vim.keymap.set('n', '<C-u>', '<C-u>zz', {
  desc = 'Scroll half screen up with stabilization',
})

vim.keymap.set('n', '<C-d>', '<C-d>zz', {
  desc = 'Scroll half screen down with stabilization',
})

-- Remaps for dealing with word wrap
vim.keymap.set('n', '0', "v:count == 0 ? 'g0' : '0'", {
  expr = true,
  silent = true,
})

vim.keymap.set('n', '$', "v:count == 0 ? 'g$' : '$'", {
  expr = true,
  silent = true,
})

vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", {
  expr = true,
  silent = true,
})

vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", {
  expr = true,
  silent = true,
})

-- Navigation in insert mode
vim.keymap.set('i', '<A-k>', '<up>', {
  desc = 'Navigation up in insert mode',
})

vim.keymap.set('i', '<A-h>', '<left>', {
  desc = 'Navigation left in insert mode',
})

vim.keymap.set('i', '<A-l>', '<right>', {
  desc = 'Navigation right in insert mode',
})

vim.keymap.set('i', '<A-j>', '<down>', {
  desc = 'Navigation down in insert mode',
})

vim.keymap.set('i', '<A-b>', '<C-o>b', {
  desc = 'Navigation back word in insert mode',
})

vim.keymap.set('i', '<A-w>', '<C-o>w', {
  desc = 'Navigation forward word in insert mode',
})

vim.keymap.set({ 'i', 't' }, '<C-H>', '<C-w>', {
  desc = 'Delete word backward',
})

vim.keymap.set({ 'i', 't' }, '<C-D>', '<C-o>dw', {
  desc = 'Delte word forward',
})

-- How do i exit terminal in vim?
vim.keymap.set('t', '<esc>', '<C-\\><C-n>', {
  desc = 'Exit terminal',
})

-- vim.keymap.set('n', '<leader>T', vim.cmd.terminal, {
--   desc = 'Open terminal',
-- })

-- Lua execute
vim.keymap.set('n', '<leader>cX', '<cmd>source %<CR>', {
  desc = 'Execute this file with lua',
})

vim.keymap.set('n', '<leader>cx', '<cmd>.lua<CR>', {
  desc = 'Execute current line with lua',
})

vim.keymap.set('v', '<leader>cx', '<cmd>lua<CR>', {
  desc = 'Execute current selection with lua',
})

-- One more % to not use symbol row
vim.keymap.set('n', 'gm', '%', { desc = 'Jump to closing' })

-- More convenient window navigation
vim.keymap.set('n', 'gh', '<C-w>h', { desc = 'Jump to left window' })
vim.keymap.set('n', 'gj', '<C-w>j', { desc = 'Jump to bottom window' })
vim.keymap.set('n', 'gk', '<C-w>k', { desc = 'Jump to top window' })
vim.keymap.set('n', 'gl', '<C-w>l', { desc = 'Jump to right window' })

-- Command sugar for replace
vim.keymap.set('v', '<leader>rr', '"hy:%s/<C-r>h//g<left><left>', {
  desc = 'Replace current selection',
})

vim.keymap.set('n', '<leader>rr', '"hyiw:%s/<C-r>h//g<left><left>', {
  desc = 'Replace word under cursor',
})

-- Yank current file path to system buffer
vim.keymap.set('n', '<leader>fy', function()
  vim.fn.setreg('*', vim.fn.expand '%:.')
end, { desc = 'Yank path' })

-- Focus current buffer
vim.keymap.set('n', '<leader><cr>', function()
  vim.cmd 'only'
end, { desc = 'Focus current buffer' })

-- Replace stupid windows path separators
vim.keymap.set('n', '<leader>f\\/', function()
  vim.cmd '%s/\\\\/\\//g'
end, { desc = 'Replace \\ with /' })

-- Zen mode
vim.keymap.set('n', '<leader>z', require('helpers.zen').toggle_zen_mode, {
  desc = 'Zen Mode',
})

-- Toggle quickfix
vim.keymap.set('n', '<leader>q', function()
  vim.cmd 'ToggleQuickfix'
end, {
  noremap = true,
  silent = true,
  desc = 'Toggle quickfix',
})
