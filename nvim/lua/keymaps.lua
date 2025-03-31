-- [[ Keymaps for better default experience ]]
vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', {
  silent = true,
})

vim.keymap.set({ 'n', 'i', 'v' }, '<F1>', '<Esc>', {
  silent = true,
})

vim.keymap.set('v', 'J', ":m '>+1<CR>gv=gv", {
  desc = 'Move selection down',
})

vim.keymap.set('v', 'Z', 'J', {
  desc = 'Join lines',
})

vim.keymap.set('v', 'K', ":m '<-2<CR>gv=gv", {
  desc = 'Move selection up',
})

vim.keymap.set('n', 'J', 'mzJ`z')

-- Useless for me - L and H
vim.keymap.set({ 'n', 'v' }, 'L', '$')
vim.keymap.set({ 'n', 'v' }, 'H', '_')

-- Jump to begin end of a tag
vim.keymap.set('n', ']t', 'vat<esc>', { desc = 'Next tag' })
vim.keymap.set('n', '[t', 'vato<esc>', { desc = 'Prev tag' })

-- Quickfix list

vim.keymap.set('n', ']q', function()
  pcall(vim.cmd, 'cnext')
end, { desc = 'Next quicklist entry' })

vim.keymap.set('n', '[q', function()
  pcall(vim.cmd, 'cprev')
end, { desc = 'Next quicklist entry' })

-- Focus current buffer
vim.keymap.set('n', '<leader>O', function()
  vim.cmd 'only'
end, { desc = 'Focus only window' })

-- disable default control keymaps
vim.keymap.set('i', '<C-k>', '<NOP>', {})
vim.keymap.set('i', '<C-j>', '<NOP>', {})

vim.keymap.set('v', 'p', 'P', {
  desc = 'Paste without copying selected text in visual mode',
})

-- vim.keymap.set('v', 'p', '"0p')

vim.keymap.set('n', '<C-u>', '<C-u>zz', {
  desc = 'Scroll half screen up with stabilization',
})

vim.keymap.set('n', '<C-d>', '<C-d>zz', {
  desc = 'Scroll half screen down with stabilization',
})

vim.keymap.set('n', '<C-s>', function()
  vim.cmd 'update'
end, { desc = 'A bit more convenient save file' })

vim.keymap.set('i', '<C-s>', '<Esc>:update<cr>gi', {
  desc = 'A bit more convenient save file',
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

vim.keymap.set('i', '<C-H>', '<C-w>', {
  desc = 'Ctrl + Backspace "default" behavior',
})

vim.keymap.set('i', '<C-Del>', '<C-o>dw', {
  desc = 'Ctrl + Del "default" behavior',
})

-- How do i exit terminal in vim?

vim.keymap.set('t', '<esc>', '<C-\\><C-n>', {
  desc = 'Exit terminal',
})

vim.keymap.set('t', '<C-H>', '<C-w>', {
  desc = 'Ctrl + Backspace "default" behavior',
})

vim.keymap.set('n', '<leader>T', vim.cmd.terminal, {
  desc = 'Open terminal',
})

-- lua execute

vim.keymap.set('n', '<leader>cX', '<cmd>source %<CR>', {
  desc = 'e[X]ecute this file with lua',
})

vim.keymap.set('n', '<leader>cx', '<cmd>.lua<CR>', {
  desc = 'e[X]ecute current line with lua',
})

vim.keymap.set('v', '<leader>cx', '<cmd>lua<CR>', {
  desc = 'e[X]ecute current selection with lua',
})

vim.keymap.set('n', '<leader>o', '<CMD>Oil<CR>', {
  desc = 'Open parent directory',
})
-- vim: ts=2 sts=2 sw=2 et
