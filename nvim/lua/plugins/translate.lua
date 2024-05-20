return {
  'uga-rosa/translate.nvim',
  keys = {
    {
      '<leader>tu',
      ':Translate UK<cr>',
      mode = { 'x', 'n' },
      desc = 'Translate to Ukrainian',
    },
    {
      '<leader>te',
      ':Translate EN<cr>',
      mode = { 'x', 'n' },
      desc = 'Translate to English',
    },
  },
  config = function()
    require('which-key').register({
      ['<leader>t'] = '[T]ranslate',
    }, { mode = { 'x', 'n' } })
  end,
}
