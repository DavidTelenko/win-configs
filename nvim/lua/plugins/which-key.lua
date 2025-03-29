return {
  'folke/which-key.nvim',
  event = 'VeryLazy',
  config = function()
    require('which-key').setup {
      win = {
        border = 'rounded',
      },
    }

    -- document existing key chains
    require('which-key').add {
      { '<leader>c', group = 'Code' },
      { '<leader>c_', hidden = true },
      { '<leader>d', group = 'Debug' },
      { '<leader>d_', hidden = true },
      { '<leader>f', group = 'Find' },
      { '<leader>f_', hidden = true },
      { '<leader>g', group = 'Git' },
      { '<leader>g_', hidden = true },
      { '<leader>r', group = 'Refactor' },
      { '<leader>r_', hidden = true },
      { '<leader>s', group = 'Search' },
      { '<leader>s_', hidden = true },
      { '<leader>w', group = 'Workspace' },
      { '<leader>w_', hidden = true },
      { '<leader>x', group = 'Trouble' },
      { '<leader>x_', hidden = true },
    }
  end,
}
