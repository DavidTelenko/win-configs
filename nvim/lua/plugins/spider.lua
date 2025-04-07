return {
  {
    'chrisgrieser/nvim-spider',
    enabled = true,
    opts = {
      skipInsignificantPunctuation = false,
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
        disabledDefaults = { 'L', 'H', 'r', 'iS', 'aS' },
      },
    },
    config = function()
      local objs = require 'various-textobjs'

      --- who needs sentence anyway?)

      vim.keymap.set({ 'o', 'x' }, 'is', function()
        objs.subword 'inner'
      end, { remap = true })

      vim.keymap.set({ 'o', 'x' }, 'as', function()
        objs.subword 'outer'
      end, { remap = true })
    end,
  },
}
