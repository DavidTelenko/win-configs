return {
  'nvim-lualine/lualine.nvim',
  enabled = true,
  lazy = false,
  dependencies = {
    'nvim-tree/nvim-web-devicons',
  },
  opts = {
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
      lualine_b = {
        { 'branch', icon = '󰘬' },
        'diagnostics',
      },
      lualine_c = { 'filename' },
      lualine_x = {
        {
          'lsp_status',
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
    inactive_sections = {
      lualine_a = {},
      lualine_b = {},
      lualine_c = {},
      lualine_x = {},
      lualine_y = {},
      lualine_z = {},
    },
    tabline = {},
    winbar = {},
    inactive_winbar = {},
    extensions = {
      'lazy',
      'mason',
      'quickfix',
      {
        sections = {
          lualine_a = {
            function()
              return '󰘬 ' .. vim.fn.FugitiveHead()
            end,
          },
          lualine_z = { 'location' },
        },
        filetypes = { 'fugitive' },
      },
      {
        sections = {
          lualine_a = {
            function()
              local ft = vim.opt_local.filetype:get()
              return (ft == 'undotree') and '󰐅 Undotree'
                or (ft == 'diff') and '󰐆 Diff'
            end,
          },
          lualine_z = { 'location' },
        },
        filetypes = { 'undotree', 'diff' },
      },
      {
        sections = {
          lualine_a = {
            function()
              return ' Telescope'
            end,
          },
        },
        filetypes = { 'TelescopePrompt' },
      },
      {
        sections = {
          lualine_a = {
            function()
              return ' Harpoon'
            end,
          },
          lualine_z = { 'location' },
        },
        filetypes = { 'harpoon' },
      },
    },
  },
}
