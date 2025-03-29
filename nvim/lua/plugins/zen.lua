return {
  'folke/zen-mode.nvim',
  keys = {
    { '<leader>z', '<cmd>ZenMode<cr>', silent = true, desc = 'Zen Mode' },
  },
  opts = {
    on_open = function()
      vim.o.listchars = ''
    end,
    on_close = function()
      vim.o.listchars = 'tab:· ,trail:·,nbsp:+,space:·'
    end,
  },
}
