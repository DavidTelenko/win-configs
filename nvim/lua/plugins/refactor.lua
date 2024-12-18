return {
  'ThePrimeagen/refactoring.nvim',
  keys = {
    { '<leader>re', ':Refactor extract ', mode = 'x', desc = '[E]xtract' },
    {
      '<leader>rf',
      ':Refactor extract_to_file ',
      mode = 'x',
      desc = 'Extract to [F]ile',
    },
    {
      '<leader>rv',
      ':Refactor extract_var ',
      mode = 'x',
      desc = 'Extract [V]ariable',
    },
    { '<leader>rI', ':Refactor inline_func', desc = '[I]nline function' },
    { '<leader>rb', ':Refactor extract_block', desc = 'Extract [B]lock' },
    { '<leader>rbf', ':Refactor extract_block_to_file', desc = 'To [F]ile' },
    {
      '<leader>ri',
      ':Refactor inline_var',
      mode = { 'n', 'x' },
      desc = '[I]nline variable',
    },
  },
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-treesitter/nvim-treesitter',
  },
  config = function()
    require('refactoring').setup {}

    require('which-key').add {
      { '<leader>r', desc = '[R]efactor', mode = 'x' },
    }
  end,
}
