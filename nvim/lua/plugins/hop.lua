return {
  'smoka7/hop.nvim',
  event = { 'BufEnter' },
  keys = {
    { 's', '<NOP>', mode = { 'n', 'v' }, desc = 'Hop' },
    {
      'sa',
      '<cmd>HopAnywhere<cr>',
      mode = { 'n', 'v' },
      desc = 'Hop anywhere',
    },
    {
      'sf',
      '<cmd>HopChar1<cr>',
      mode = { 'n', 'v' },
      desc = 'Hop to character',
    },
    {
      'ss',
      '<cmd>HopPattern<cr>',
      mode = { 'n', 'v' },
      desc = 'Hop to pattern',
    },
    { 'sl', '<cmd>HopLine<cr>', mode = { 'n', 'v' }, desc = 'Hop to line' },
    {
      'st',
      '<cmd>HopNodes<cr>',
      mode = { 'n', 'v' },
      desc = 'Hop to treesitter nodes',
    },
  },
  version = '*',
  opts = {
    keys = 'asdfghjkl;',
  },
}
