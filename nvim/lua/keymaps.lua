-- [[ Basic Keymaps ]]

-- Keymaps for better default experience
vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })

-- Remap for dealing with word wrap
vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- Diagnostic keymaps
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = 'Go to previous diagnostic message' })
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = 'Go to next diagnostic message' })

vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, { desc = 'Open floating diagnostic message' })
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostics list' })

vim.keymap.set('n', '<leader>i', function()
  vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled {})
end, { desc = 'Enable [I]nline hints' })

vim.keymap.set('n', '<C-u>', '<C-u>zz', { desc = 'Scroll half screen up with stablization' })
vim.keymap.set('n', '<C-d>', '<C-d>zz', { desc = 'Scroll half screen down with stabilization' })

vim.keymap.set('n', '<C-s>', ':update<cr>', { desc = 'A bit more convenient save file' })
vim.keymap.set('i', '<C-s>', '<Esc>:update<cr>gi', { desc = 'A bit more convenient save file' })

vim.keymap.set('i', '<A-k>', '<C-o>gk', { desc = 'Navigation up in insert mode' })
vim.keymap.set('i', '<A-h>', '<C-o>h', { desc = 'Navigation left in insert mode' })
vim.keymap.set('i', '<A-l>', '<C-o>l', { desc = 'Navigation right in insert mode' })
vim.keymap.set('i', '<A-j>', '<C-o>gj', { desc = 'Navigation down in insert mode' })
vim.keymap.set('i', '<A-b>', '<C-o>b', { desc = 'Navigation back word in insert mode' })
vim.keymap.set('i', '<A-w>', '<C-o>w', { desc = 'Navigation forward word in insert mode' })

vim.keymap.set('i', '<C-H>', '<C-w>', { desc = 'Ctrl + Backspace "default" behavior' })
vim.keymap.set('i', '<C-Del>', '<C-o>dw', { desc = 'Ctrl + Del "default" behavior' })
vim.keymap.set('i', '<C-z>', '<esc>ua', { desc = 'Undo wiht Ctrl + Z' })

-- paste without copying selected text in visual mode
vim.keymap.set('v', 'p', 'P')
-- vim.keymap.set('v', 'p', '"0p')

-- How do i exit terminal in vim?
vim.keymap.set('t', '<esc>', '<C-\\><C-n>', { desc = 'Exit terminal' })
vim.keymap.set('t', '<C-H>', '<C-w>', { desc = 'Ctrl + Backspace "default" behavior' })

vim.keymap.set('n', '<leader>T', vim.cmd.terminal, { desc = 'Open [T]erminal' })

-- Useless for me - L and H
vim.keymap.set({ 'n', 'v' }, 'L', 'e')
vim.keymap.set({ 'n', 'v' }, 'H', 'b')

-- vim.keymap.set('n', '<tab>', ':E<cr>', { desc = 'Open Explorer' })

-- vim: ts=2 sts=2 sw=2 et
