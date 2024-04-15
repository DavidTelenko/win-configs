-- Set lualine as statusline

return {
  'nvim-lualine/lualine.nvim',
  -- See `:help lualine.txt`
  opts = {
    options = {
      icons_enabled = false,
      theme = require("plugins.theme").theme,
      component_separators = '|',
      section_separators = '',
    },
  },
}

-- vim: ts=2 sts=2 sw=2 et
