return {
  'nvim-lualine/lualine.nvim',
  lazy = false,
  opts = function()
    local filename = require('lualine.components.filename'):extend()
    filename.apply_icon = require('lualine.components.filetype').apply_icon

    return {
      options = {
        icons_enabled = true,
        theme = 'auto',
        component_separators = '',
        section_separators = { right = '', left = '' },
        disabled_filetypes = {
          statusline = {},
          winbar = {},
        },
        ignore_focus = {},
        always_divide_middle = true,
        globalstatus = true,
        refresh = {
          statusline = 100,
          tabline = 1000,
          winbar = 1000,
        },
      },
      sections = {
        lualine_a = { 'mode' },
        lualine_b = { { 'branch', icon = '󰘬' }, 'diagnostics' },
        lualine_c = { filename },
        lualine_x = {
          {
            'lsp_status',
            icon = '',
            symbols = {
              done = '',
              separator = ' ',
            },
            ignore_lsp = {
              'emmet_language_server',
              'tailwindcss',
            },
          },
        },
        lualine_y = {
          {
            'diff',
            symbols = { added = ' ', modified = ' ', removed = ' ' },
          },
        },
        lualine_z = { 'location' },
      },
      tabline = {},
      winbar = {},
      inactive_winbar = {},
    }
  end,
}
