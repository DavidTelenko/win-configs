return {
  'chrisgrieser/nvim-various-textobjs',
  keys = { 'v', 'd', 'y' },
  opts = {
    keymaps = {
      useDefaults = true,
      disabledDefaults = {
        'L',
        'C',
        'r',
        'iS',
        'aS',
        'ik',
        'ak',
        'iv',
        'av',
        'gw',
        'gW',
      },
    },
  },
  config = function(_, opts)
    local objs = require 'various-textobjs'
    objs.setup(opts)

    vim.keymap.set({ 'o', 'x' }, 'is', function()
      objs.subword 'inner'
    end, { remap = true, desc = 'inner subword' })

    vim.keymap.set({ 'o', 'x' }, 'as', function()
      objs.subword 'outer'
    end, { remap = true, desc = 'outer subword' })
  end,
}
