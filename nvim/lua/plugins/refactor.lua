return {
  'ThePrimeagen/refactoring.nvim',
  keys = {
    { '<leader>re', ':Refactor extract ', mode = 'x', desc = 'Extract' },
    {
      '<leader>rf',
      ':Refactor extract_to_file ',
      mode = 'x',
      desc = 'Extract to File',
    },
    {
      '<leader>rv',
      ':Refactor extract_var ',
      mode = 'x',
      desc = 'Extract Variable',
    },
    { '<leader>rI', ':Refactor inline_func', desc = 'Inline function' },
    { '<leader>rb', ':Refactor extract_block', desc = 'Extract Block' },
    { '<leader>rbf', ':Refactor extract_block_to_file', desc = 'To File' },
    {
      '<leader>ri',
      ':Refactor inline_var',
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
