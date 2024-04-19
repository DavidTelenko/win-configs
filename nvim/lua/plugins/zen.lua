return {
  {
    'folke/zen-mode.nvim',
    dependencies = {
      'folke/twilight.nvim',
    },
    config = function()
      local zen = require('zen-mode')
      zen.setup({})
      vim.keymap.set('n', '<leader>z', zen.toggle, { silent = true })
    end
  },
}
