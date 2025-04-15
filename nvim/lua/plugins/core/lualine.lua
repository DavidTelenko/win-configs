return {
  'nvim-lualine/lualine.nvim',
  lazy = false,
  opts = function()
    local filename = require('lualine.components.filename'):extend()
    filename.apply_icon = require('lualine.components.filetype').apply_icon

    local lsp_status = {
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
    }

    local diff = {
      'diff',
      symbols = { added = ' ', modified = ' ', removed = ' ' },
    }

    local default_extension = function(name, filetype)
      return {
        sections = {
          lualine_a = { 'mode' },
          lualine_b = { { 'branch', icon = '󰘬' }, 'diagnostics' },
          lualine_c = { name },
          lualine_x = { lsp_status },
          lualine_y = { diff },
          lualine_z = { 'location' },
        },
        filetypes = { filetype },
      }
    end

    local extensions = {
      oil = default_extension(function()
        return '󰖌 Oil'
      end, 'oil'),

      harpoon = default_extension(function()
        return '󰀱 Harpoon'
      end, 'harpoon'),

      telescope = default_extension(function()
        return '󰭎 Telescope'
      end, 'TelescopePrompt'),

      undotree = default_extension(function()
        return ' Undotree'
      end, 'undotree'),

      diff = default_extension(function()
        return '󰳻 Diff'
      end, 'diff'),

      fugitive = default_extension(function()
        return '󰘬 ' .. vim.fn.FugitiveHead()
      end, 'fugitive'),
    }

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
      sections = default_extension(filename).sections,
      tabline = {},
      winbar = {},
      inactive_winbar = {},
      extensions = {
        'lazy',
        'mason',
        'quickfix',
        extensions.fugitive,
        extensions.oil,
        extensions.diff,
        extensions.undotree,
        extensions.telescope,
        extensions.harpoon,
      },
    }
  end,
}
