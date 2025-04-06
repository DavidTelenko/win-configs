return {
  'folke/which-key.nvim',
  event = 'VeryLazy',
  config = function()
    require('which-key').setup {
      preset = 'helix',
    }

    -- document existing key chains
    require('which-key').add {
      { '<leader>c', group = 'Code', mode = { 'x', 'n' } },
      { '<leader>c_', hidden = true },
      { '<leader>d', group = 'Debug' },
      { '<leader>d_', hidden = true },
      { '<leader>f', group = 'File' },
      { '<leader>f_', hidden = true },
      { '<leader>g', group = 'Git', mode = { 'x', 'n' } },
      { '<leader>g_', hidden = true },
      { '<leader>r', group = 'Refactor', mode = { 'x', 'n' } },
      { '<leader>r_', hidden = true },
      { '<leader>s', group = 'Search' },
      { '<leader>s_', hidden = true },
      { '<leader>w', group = 'Workspace' },
      { '<leader>w_', hidden = true },
      { '<leader>x', group = 'Trouble' },
      { '<leader>x_', hidden = true },
      { '<leader>t', group = 'Test' },
      { '<leader>t_', hidden = true },
      { '<leader>h', group = 'Harpoon' },
      { '<leader>h_', hidden = true },
      { '<leader>i', group = 'Iron' },
      { '<leader>i_', hidden = true },
    }
  end,
}
