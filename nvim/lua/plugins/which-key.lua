return {
  -- - `opts.motions`: option is deprecated.
  -- - `opts.operators`: option is deprecated. see `opts.defer`
  -- - `opts.window`: option is deprecated. see `opts.win`
  -- - `opts.triggers`: triggers must be a table
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
      { "<leader>c",  group = "[C]ode" },
      { "<leader>c_", hidden = true },
      { "<leader>d",  group = "[D]ebug" },
      { "<leader>d_", hidden = true },
      { "<leader>f",  group = "[F]ind = [S]earch" },
      { "<leader>f_", hidden = true },
      { "<leader>g",  group = "[G]it" },
      { "<leader>g_", hidden = true },
      { "<leader>r",  group = "[R]efactor" },
      { "<leader>r_", hidden = true },
      { "<leader>s",  group = "[S]earch" },
      { "<leader>s_", hidden = true },
      { "<leader>w",  group = "[W]orkspace" },
      { "<leader>w_", hidden = true },
    }
  end,
}
