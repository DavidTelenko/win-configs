return {
  'smoka7/hop.nvim',
  keys = {
    { 's', '<NOP>', mode = { 'n' }, desc = 'Hop' },
    {
      's/',
      '<cmd>HopPattern<cr>',
      mode = { 'n', 'v' },
      desc = 'Hop to pattern',
    },
    {
      'sl',
      '<cmd>HopLine<cr>',
      mode = { 'n', 'v' },
      desc = 'Hop to line',
    },
    {
      'st',
      '<cmd>HopNodes<cr>',
      mode = { 'n', 'v' },
      desc = 'Hop to treesitter nodes',
    },
    { 'sf', desc = 'Hop to character', mode = { 'n', 'v' } },
  },
  opts = {},
  config = function(_, opts)
    local hop = require 'hop'

    hop.setup(opts)

    vim.keymap.set({ 'n', 'v' }, 'sf', function()
      hop.hint_char1 {
        current_line_only = false,
        jump_on_sole_occurrence = false,
      }
    end, { remap = true })
  end,
}
