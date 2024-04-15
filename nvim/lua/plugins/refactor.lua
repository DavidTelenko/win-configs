-- Neat little refactoring plugin

return {
  "ThePrimeagen/refactoring.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-treesitter/nvim-treesitter",
  },
  config = function()
    require("refactoring").setup({})
    vim.keymap.set('x', '<leader>re', ':Refactor extract ', { desc = '[E]xtract' })
    vim.keymap.set('x', '<leader>rf', ':Refactor extract_to_file ', { desc = 'Extract to [F]ile' })

    vim.keymap.set('x', '<leader>rv', ':Refactor extract_var ', { desc = 'Extract [V]ariable' })

    vim.keymap.set({ 'n', 'x' }, '<leader>ri', ':Refactor inline_var', { desc = '[I]nline variable' })

    vim.keymap.set('n', '<leader>rI', ':Refactor inline_func', { desc = '[I]nline function' })

    vim.keymap.set('n', '<leader>rb', ':Refactor extract_block', { desc = 'Extract [B]lock' })
    vim.keymap.set('n', '<leader>rbf', ':Refactor extract_block_to_file', { desc = 'To [F]ile' })

    require('which-key').register({
      ['<leader>r'] = '[R]efactor',
    }, { mode = 'x' })
  end,
}

-- vim: ts=2 sts=2 sw=2 et