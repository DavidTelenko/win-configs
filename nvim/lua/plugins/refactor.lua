return {
  'ThePrimeagen/refactoring.nvim',
  keys = {
    { '<leader>re', '<cmd>Refactor extract ', mode = 'x', desc = 'Extract' },
    {
      '<leader>rf',
      '<cmd>Refactor extract_to_file ',
      mode = 'x',
      desc = 'Extract to File',
    },
    {
      '<leader>rv',
      '<cmd>Refactor extract_var ',
      mode = 'x',
      desc = 'Extract Variable',
    },
    { '<leader>rI', '<cmd>Refactor inline_func', desc = 'Inline function' },
    { '<leader>rb', '<cmd>Refactor extract_block', desc = 'Extract Block' },
    { '<leader>rbf', '<cmd>Refactor extract_block_to_file', desc = 'To File' },
    {
      '<leader>ri',
      '<cmd>Refactor inline_var',
      mode = { 'n', 'x' },
      desc = 'Inline variable',
    },
  },
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-treesitter/nvim-treesitter',
  },
  opts = {},
}
