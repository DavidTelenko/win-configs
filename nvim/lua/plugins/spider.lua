return {
  {
    'chrisgrieser/nvim-spider',
    opts = {
      skipInsignificantPunctuation = true,
      consistentOperatorPending = false,
      subwordMovement = true,
      customPatterns = {},
    },
    keys = {
      {
        'w',
        "<cmd>lua require('spider').motion('w')<CR>",
        mode = { 'n', 'o', 'x' },
      },
      {
        'e',
        "<cmd>lua require('spider').motion('e')<CR>",
        mode = { 'n', 'o', 'x' },
      },
      {
        'b',
        "<cmd>lua require('spider').motion('b')<CR>",
        mode = { 'n', 'o', 'x' },
      },
    },
  },
  {
    'chrisgrieser/nvim-various-textobjs',
    event = 'VeryLazy',
    opts = {
      keymaps = {
        useDefaults = true,
        disabledDefaults = { 'iS', 'aS' },
      },
    },
    keys = {
      {
        'is',
        "<cmd>lua require('various-textobjs').subword('inner')<CR>",
        mode = { 'o', 'x' },
        desc = '',
      },
      {
        'as',
        "<cmd>lua require('various-textobjs').subword('outer')<CR>",
        mode = { 'o', 'x' },
        desc = '',
      },
    },
  },
}
