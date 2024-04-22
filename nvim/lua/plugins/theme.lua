local transparent = true

return {
  {
    'lukas-reineke/indent-blankline.nvim',
    event = 'BufReadPre',
    main = 'ibl',
    opts = {
      indent = { char = '▏' },
    },
  },
  {
    'folke/todo-comments.nvim',
    event = 'BufReadPre',
    dependencies = {
      'nvim-lua/plenary.nvim',
    },
    opts = {},
  },
  {
    'ellisonleao/gruvbox.nvim',
    enabled = true,
    event = 'VimEnter',
    config = function()
      require('gruvbox').setup {
        terminal_colors = true, -- add neovim terminal colors
        undercurl = true,
        underline = true,
        bold = true,
        italic = {
          strings = false,
          emphasis = false,
          comments = false,
          operators = false,
          folds = false,
        },
        strikethrough = true,
        invert_selection = false,
        invert_signs = false,
        invert_tabline = false,
        invert_intend_guides = false,
        inverse = true, -- invert background for search, diffs, statuslines and errors
        contrast = '',  -- can be "hard", "soft" or empty string
        palette_overrides = {},
        overrides = {},
        dim_inactive = false,
        transparent_mode = transparent,
      }
      vim.cmd.colorscheme 'gruvbox'
    end,
  },
  {
    'navarasu/onedark.nvim',
    enabled = false,
    config = function()
      require('onedark').setup {
        -- Main options --
        style = 'warm',               -- Default theme style. Choose between 'dark', 'darker', 'cool', 'deep', 'warm', 'warmer' and 'light'
        transparent = transparent,    -- Show/hide background
        term_colors = true,           -- Change terminal color as per the selected theme style
        ending_tildes = false,        -- Show the end-of-buffer tildes. By default they are hidden
        cmp_itemkind_reverse = false, -- reverse item kind highlights in cmp menu

        -- toggle theme style ---
        toggle_style_key = nil,                                                              -- keybind to toggle theme style. Leave it nil to disable it, or set it to a string, for example "<leader>ts"
        toggle_style_list = { 'dark', 'darker', 'cool', 'deep', 'warm', 'warmer', 'light' }, -- List of styles to toggle between

        -- Change code style ---
        -- Options are italic, bold, underline, none
        -- You can configure multiple style with comma separated, For e.g., keywords = 'italic,bold'
        code_style = {
          comments = 'none',
          keywords = 'none',
          functions = 'none',
          strings = 'none',
          variables = 'none',
        },

        -- Lualine options --
        lualine = {
          transparent = transparent, -- lualine center bar transparency
        },

        -- Custom Highlights --
        colors = {},     -- Override default colors
        highlights = {}, -- Override highlight groups

        -- Plugins Config --
        diagnostics = {
          darker = true,     -- darker colors for diagnostic
          undercurl = true,  -- use undercurl instead of underline for diagnostics
          background = true, -- use background color for virtual text
        },
      }
      vim.cmd.colorscheme 'onedark'
    end,
  },
  {
    'folke/tokyonight.nvim',
    enabled = false,
    config = function()
      require('tokyonight').setup {
        -- your configuration comes here
        -- or leave it empty to use the default settings
        style = 'storm',           -- The theme comes in three styles, `storm`, `moon`, a darker variant `night` and `day`
        transparent = transparent, -- Enable this to disable setting the background color
        terminal_colors = true,    -- Configure the colors used when opening a `:terminal` in Neovim
        styles = {
          -- Style to be applied to different syntax groups
          -- Value is any valid attr-list value for `:help nvim_set_hl`
          comments = { italic = false },
          keywords = { italic = false },
          -- Background styles. Can be "dark", "transparent" or "normal"
          sidebars = 'dark', -- style for sidebars, see below
          floats = 'dark',   -- style for floating windows
        },
      }
      vim.cmd.colorscheme 'tokyonight'
    end,
  },
  {
    'rose-pine/neovim',
    enabled = false,
    name = 'rose-pine',
    config = function()
      require('rose-pine').setup {
        styles = {
          italic = false,
        },
      }
      vim.cmd.colorscheme 'rose-pine'
    end,
  },
}
