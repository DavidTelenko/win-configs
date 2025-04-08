return {
  {
    'chrisgrieser/nvim-spider',
    opts = {
      skipInsignificantPunctuation = false,
      consistentOperatorPending = false,
      subwordMovement = true,
      customPatterns = {},
    },
    keys = {
      -- |
      -- V the word here is what spider creates)
      { 'w', mode = { 'n', 'o', 'x' }, desc = 'Next word' },
      { 'e', mode = { 'n', 'o', 'x' }, desc = 'Next end of word' },
      { 'b', mode = { 'n', 'o', 'x' }, desc = 'Prev word' },
    },
    config = function(_, opts)
      local spider = require 'spider'
      spider.setup(opts)

      vim.keymap.set({ 'n', 'o', 'x' }, 'w', function()
        spider.motion 'w'
      end, { remap = true, desc = 'Next word' })

      vim.keymap.set({ 'n', 'o', 'x' }, 'e', function()
        spider.motion 'e'
      end, { remap = true, desc = 'Next end of word' })

      vim.keymap.set({ 'n', 'o', 'x' }, 'b', function()
        spider.motion 'b'
      end, { remap = true, desc = 'Prev word' })
    end,
  },
  {
    'chrisgrieser/nvim-various-textobjs',
    opts = {
      keymaps = { useDefaults = false },
    },
    keys = {
      { 'is', desc = 'subword', mode = { 'o', 'x' } },
      { 'as', desc = 'subword', mode = { 'o', 'x' } },
      { 'ib', desc = 'any bracket', mode = { 'o', 'x' } },
      { 'ab', desc = 'any bracket', mode = { 'o', 'x' } },
      { 'iq', desc = 'any quoute', mode = { 'o', 'x' } },
      { 'aq', desc = 'any quoute', mode = { 'o', 'x' } },
      { 'ii', desc = 'indentation', mode = { 'o', 'x' } },
      { 'ai', desc = 'indentation', mode = { 'o', 'x' } },
    },
    config = function(_, opts)
      local objs = require 'various-textobjs'
      objs.setup(opts)

      vim.keymap.set({ 'o', 'x' }, 'is', function()
        objs.subword 'inner'
      end, { remap = true, desc = 'subword' })

      vim.keymap.set({ 'o', 'x' }, 'as', function()
        objs.subword 'outer'
      end, { remap = true, desc = 'subword' })

      vim.keymap.set({ 'o', 'x' }, 'ib', function()
        objs.anyBracket 'inner'
      end, { remap = true, desc = 'any bracket' })

      vim.keymap.set({ 'o', 'x' }, 'ab', function()
        objs.anyBracket 'outer'
      end, { remap = true, desc = 'any bracket' })

      vim.keymap.set({ 'o', 'x' }, 'iq', function()
        objs.anyQuote 'inner'
      end, { remap = true, desc = 'any quoute' })

      vim.keymap.set({ 'o', 'x' }, 'aq', function()
        objs.anyQuote 'outer'
      end, { remap = true, desc = 'any quoute' })

      vim.keymap.set({ 'o', 'x' }, 'ii', function()
        objs.indentation 'inner'
      end, { remap = true, desc = 'indentation' })

      vim.keymap.set({ 'o', 'x' }, 'ai', function()
        objs.indentation 'outer'
      end, { remap = true, desc = 'indentation' })
    end,
  },
}
