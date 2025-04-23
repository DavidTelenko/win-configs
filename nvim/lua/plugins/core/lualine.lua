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
        section_separators = { right = '', left = '' },
        disabled_filetypes = {
          statusline = {},
          winbar = {},
        },
        ignore_focus = {},
        always_divide_middle = true,
        always_show_tabline = false,
        globalstatus = true,
        refresh = {
          statusline = 100,
          tabline = 100,
          winbar = 1000,
        },
      },
      sections = {
        lualine_a = {
          {
            'mode',
            fmt = function(str)
              return str:sub(1, 1)
            end,
          },
        },
        lualine_b = { { 'branch', icon = '󰘬' }, 'diagnostics' },
        lualine_c = { { filename, path = 1 } },
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
      tabline = {
        lualine_a = { 'tabs' },
      },
      winbar = {},
      inactive_winbar = {},
    }
  end,
}
