return {
  {
    'j-hui/fidget.nvim',
    event = 'BufReadPre',
    enabled = true,
    opts = {},
  },
  {
    'rcarriga/nvim-notify',
    event = 'BufReadPre',
    enabled = false,
    config = function()
      require('notify').setup {
        background_colour = '#000000',
        stages = 'fade',
        timeout = 1500,
        top_down = true,
        max_width = 60,
        render = 'wrapped-compact',
        level = 'WARN',
      }

      local telescope = require 'telescope'

      telescope.load_extension 'notify'

      vim.keymap.set('n', '<leader>sn', telescope.extensions.notify.notify, {
        desc = '[S]earch [N]otifications',
      })
    end,
  },
}
