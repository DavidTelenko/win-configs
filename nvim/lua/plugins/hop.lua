return {
  'smoka7/hop.nvim',
  event = { 'BufEnter' },
  keys = {
    { 's', '<NOP>', mode = 'n', desc = 'Hop' },
    { 'sa', '<cmd>HopAnywhere<cr>', mode = 'n', desc = 'Hop anywhere' },
    { 'sf', '<cmd>HopChar1<cr>', mode = 'n', desc = 'Hop to character' },
    { 'ss', '<cmd>HopPattern<cr>', mode = 'n', desc = 'Hop to pattern' },
    { 'sl', '<cmd>HopLine<cr>', mode = 'n', desc = 'Hop to line' },
    { 'st', '<cmd>HopNodes<cr>', mode = 'n', desc = 'Hop to treesitter nodes' },
  },
  version = '*',
  opts = {
    keys = 'asdfghjkl;',
  },
}
