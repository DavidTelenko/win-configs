return {
  'nvim-lualine/lualine.nvim',
  lazy = false,
  opts = function()
    local filename = require('lualine.components.filename'):extend()
    filename.apply_icon = require('lualine.components.filetype').apply_icon

    local colors = require('gruvbox').palette

    return {
      options = {
        icons_enabled = true,
        theme = {
          normal = {
            a = { bg = colors.light2, fg = colors.dark0, gui = 'bold' },
            b = { bg = colors.dark0, fg = colors.light2 },
            c = { bg = colors.dark1, fg = colors.light3 },
          },
          insert = {
            a = { bg = colors.bright_blue, fg = colors.dark0, gui = 'bold' },
            b = { bg = colors.dark0, fg = colors.light2 },
            c = { bg = colors.dark1, fg = colors.light1 },
          },
          visual = {
            a = { bg = colors.bright_yellow, fg = colors.dark0, gui = 'bold' },
            b = { bg = colors.dark0, fg = colors.light2 },
            c = { bg = colors.dark1, fg = colors.light1 },
          },
          replace = {
            a = { bg = colors.bright_red, fg = colors.dark0, gui = 'bold' },
            b = { bg = colors.dark0, fg = colors.light2 },
            c = { bg = colors.dark1, fg = colors.light1 },
          },
          command = {
            a = { bg = colors.bright_green, fg = colors.dark0, gui = 'bold' },
            b = { bg = colors.dark0, fg = colors.light2 },
            c = { bg = colors.dark4, fg = colors.dark0 },
          },
          inactive = {
            a = { bg = colors.dark0, fg = colors.gray, gui = 'bold' },
            b = { bg = colors.dark0, fg = colors.gray },
            c = { bg = colors.dark0, fg = colors.gray },
          },
        },
        component_separators = '',
        section_separators = { right = '', left = '' },
        -- section_separators = { right = '', left = '' },
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
        lualine_b = {
          -- { 'branch', icon = '󰘬' },
          'diagnostics',
        },
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
