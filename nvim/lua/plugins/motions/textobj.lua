return {
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
}
