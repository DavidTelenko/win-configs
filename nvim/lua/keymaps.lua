-- [[ Basic Keymaps ]]

-- Keymaps for better default experience
vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })
vim.keymap.set({ 'n', 'i', 'v' }, '<F1>', '<Esc>', { silent = true })

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

vim.keymap.set('i', '<A-k>', '<up>', { desc = 'Navigation up in insert mode' })
vim.keymap.set('i', '<A-h>', '<left>', { desc = 'Navigation left in insert mode' })
vim.keymap.set('i', '<A-l>', '<right>', { desc = 'Navigation right in insert mode' })
vim.keymap.set('i', '<A-j>', '<down>', { desc = 'Navigation down in insert mode' })
vim.keymap.set('i', '<A-b>', '<C-o>b', { desc = 'Navigation back word in insert mode' })
vim.keymap.set('i', '<A-w>', '<C-o>w', { desc = 'Navigation forward word in insert mode' })

vim.keymap.set('i', '<C-H>', '<C-w>', { desc = 'Ctrl + Backspace "default" behavior' })
vim.keymap.set('i', '<C-Del>', '<C-o>dw', { desc = 'Ctrl + Del "default" behavior' })

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

-- Jump to begin end of a tag
vim.keymap.set('n', ']t', 'vat<esc>', { desc = 'Jump to end of a tag' })
vim.keymap.set('n', '[t', 'vato<esc>', { desc = 'Jump to begining of a tag' })

-- disable default control keymaps
vim.keymap.set('i', '<C-k>', '<NOP>', {})
vim.keymap.set('i', '<C-j>', '<NOP>', {})

-- lua execute
vim.keymap.set('n', '<leader>cf', '<cmd>source %<CR>', { desc = 'e[X]ecute this file with lua' })
vim.keymap.set('n', '<leader>cx', '<cmd>.lua<CR>', { desc = 'e[X]ecute current line with lua' })
vim.keymap.set('v', '<leader>cx', '<cmd>lua<CR>', { desc = 'e[X]ecute current selection with lua' })

-- quicklist
vim.keymap.set('n', '<leader>qn', '<cmd>cnext<CR>', { desc = 'Jump to [N]ext quicklist entry' })
vim.keymap.set('n', '<leader>qp', '<cmd>cprev<CR>', { desc = 'Jump to [P]ev quicklist entry' })
vim.keymap.set('n', '<leader>qo', '<cmd>copen<CR>', { desc = '[O]pen quicklist' })
vim.keymap.set('n', '<leader>qc', '<cmd>cclose<CR>', { desc = '[C]lose quicklist' })

-- vim: ts=2 sts=2 sw=2 et
