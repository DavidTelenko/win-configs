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
      { '<leader>d', group = 'Debug' },
      { '<leader>f', group = 'File' },
      { '<leader>g', group = 'Git', mode = { 'x', 'n' } },
      { '<leader>gd', group = 'Diffview' },
      { '<leader>r', group = 'Refactor', mode = { 'x', 'n' } },
      { '<leader>s', group = 'Search' },
      { '<leader>t', group = 'Test' },
      { '<leader>x', group = 'Trouble' },
      {
        '<leader>w',
        group = 'Workspace',
        icon = { icon = '', color = 'green' },
      },
      {
        '<leader>h',
        group = 'Quick file (Harpoon)',
        icon = { icon = '󰓾', color = 'green' },
      },
      {
        '<leader>o',
        group = 'Open parent directory (Oil)',
        icon = { icon = '', color = 'yellow' },
      },
      {
        '<leader>z',
        group = 'Zen mode',
        icon = { icon = '', color = 'orange' },
      },
      {
        '<leader>i',
        group = 'Repl (Iron)',
        icon = { icon = '', color = 'blue' },
      },
      {
        '<leader>p',
        group = 'Pick color',
        icon = { icon = '', color = 'blue' },
      },
    }
  end,
}
