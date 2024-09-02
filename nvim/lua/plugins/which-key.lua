return {
  -- - `opts.motions`: option is deprecated.
  -- - `opts.operators`: option is deprecated. see `opts.defer`
  -- - `opts.window`: option is deprecated. see `opts.win`
  -- - `opts.triggers`: triggers must be a table
  'folke/which-key.nvim',
  event = 'VeryLazy',
  config = function()
    require('which-key').setup {
      plugins = {
        marks = true,     -- shows a list of your marks on ' and `
        registers = true, -- shows your registers on " in NORMAL or <C-r> in INSERT mode
        -- the presets plugin, adds help for a bunch of default keybindings in Neovim
        -- No actual key bindings are created
        spelling = {
          enabled = true,   -- enabling this will show WhichKey when pressing z= to select spelling suggestions
          suggestions = 20, -- how many suggestions should be shown in the list?
        },
        presets = {
          text_objects = true, -- help for text objects triggered after entering an operator
          nav = true,          -- misc bindings to work with windows
          z = true,            -- bindings for folds, spelling and others prefixed with z
          g = true,            -- bindings for prefixed with g
        },
      },
      -- add operators that will trigger motion and text object completion
      -- to enable all native operators, set the preset / operators plugin above
      icons = {
        breadcrumb = '»', -- symbol used in the command line area that shows your active key combo
        separator = '➜', -- symbol used between a key and it's label
        group = '+', -- symbol prepended to a group
      },
      win = {
        border = 'rounded',       -- none, single, double, shadow
        position = 'bottom',      -- bottom, top
        padding = { 1, 2, 1, 2 }, -- extra window padding [top, right, bottom, left]
        zindex = 1000,            -- positive value to position WhichKey above other floating windows.
      },
      layout = {
        height = { min = 4, max = 25 }, -- min and max height of the columns
        width = { min = 20, max = 50 }, -- min and max width of the columns
        spacing = 3,                    -- spacing between columns
        align = 'left',                 -- align columns left, center or right
      },
      show_help = true,                 -- show a help message in the command line for using WhichKey
      show_keys = true,                 -- show the currently pressed key and its label as a message in the command line
      triggers = { "<leader>" },        -- or specifiy a list manually
      -- list of triggers, where WhichKey should not wait for timeoutlen and show immediately
      -- disable the WhichKey popup for certain buf types and file types.
      -- Disabled by default for Telescope
      disable = {
        buftypes = {},
        filetypes = {},
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
