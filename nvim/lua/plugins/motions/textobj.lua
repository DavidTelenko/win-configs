return {
  'chrisgrieser/nvim-various-textobjs',
  keys = { 'v', 'd', 'y' },
  opts = {
    keymaps = {
      useDefaults = true,
      disabledDefaults = { 'iS', 'aS', 'L' },
    },
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
  end,
}
