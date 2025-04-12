return {
  'ThePrimeagen/refactoring.nvim',
  keys = {
    { '<leader>re', '<cmd>Refactor extract ', mode = 'x', desc = 'Extract' },
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
    { '<leader>rI', '<cmd>Refactor inline_func<cr>', desc = 'Inline function' },
    { '<leader>rb', '<cmd>Refactor extract_block<cr>', desc = 'Extract Block' },
    {
      '<leader>rbf',
      '<cmd>Refactor extract_block_to_file<cr>',
      desc = 'To File',
    },
    {
      '<leader>ri',
      '<cmd>Refactor inline_var<cr>',
      mode = { 'n', 'x' },
      desc = 'Inline variable',
    },
  },
  opts = {},
}
