return {
  'uga-rosa/ccc.nvim',
  keys = {
    { '<leader>p', '<cmd>CccPick<cr>', mode = 'n', desc = 'Pick color' },
  },
  config = function()
    local ccc = require 'ccc'

    ccc.setup {
      highlighter = {
        auto_enable = true,
        lsp = true,
      },
      bar_len = 15,
      point_char = '',
      highlight_mode = 'virtual',
      virtual_symbol = ' ',
      virtual_pos = 'inline-right',
      inputs = {
        ccc.input.hsl,
        ccc.input.cmyk,
        ccc.input.rgb,
      },
    }
  end,
}
