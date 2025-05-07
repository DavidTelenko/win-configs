return {
  'DavidTelenko/texel.nvim',
  keys = {
    { '<leader>ab', desc = 'Ask with buffer', mode = { 'n' } },
    { '<leader>as', desc = 'Open scratch markdown tab', mode = { 'n' } },
    { '<leader>a', desc = 'Ask with selection', mode = { 'v' } },
  },
  --- @module "texel"
  --- @type texel.Config
  opts = {},
  config = function(_, opts)
    local texel = require 'texel'

    texel.setup(opts)

    vim.keymap.set('v', '<leader>a', function()
      texel.chat.ask.selection()
    end, { desc = 'Ask with selection' })

    vim.keymap.set('n', '<leader>ab', function()
      texel.chat.ask.buffer()
    end, { desc = 'Ask with buffer' })

    vim.keymap.set('n', '<leader>as', function()
      vim.cmd 'tabnew'
      vim.cmd 'set filetype=markdown'
    end, { desc = 'Open scratch markdown tab buffer' })
  end,
}
