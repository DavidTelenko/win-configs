-- [[ Compiler configuration ]]
-- see `:help compiler` or `:help overseer` for more information
-- Open compiler
vim.keymap.set('n', '<S-F5>', "<cmd>update<cr><cmd>CompilerOpen<cr>", {
  noremap = true,
  silent = true,
  desc = 'Open comiler plugin menu',
})

vim.keymap.set({ 'n', 'i' }, '<F6>', "<cmd>CompilerStop<cr>:q<cr>", {
  noremap = true,
  silent = true,
  desc = 'Stop compiler and hault execution'
})

-- Redo last selected option
vim.keymap.set({ 'n', 'i' }, '<F5>',
  "<cmd>wa<cr><cmd>CompilerStop<cr><cmd>CompilerRedo<cr>", {
    noremap = true,
    silent = true,
    desc = 'Save file and rerun last selected option'
  })

-- Toggle compiler results
vim.keymap.set('n', '<S-F7>', "<cmd>CompilerToggleResults<cr>", {
  noremap = true,
  silent = true,
  desc = 'Close results window'
})
