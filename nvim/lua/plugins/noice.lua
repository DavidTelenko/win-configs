return {
  {
    'folke/noice.nvim',
    enabled = false,
    dependencies = {
      'MunifTanjim/nui.nvim',
    },
    event = 'VeryLazy',
    config = function()
      require('noice').setup {
        lsp = {
          -- override markdown rendering so that **cmp** and other plugins use **Treesitter**
          override = {
            ['vim.lsp.util.convert_input_to_markdown_lines'] = true,
            ['vim.lsp.util.stylize_markdown'] = true,
            ['cmp.entry.get_documentation'] = true, -- requires hrsh7th/nvim-cmp
          },
        },
        -- you can enable a preset for easier configuration
        presets = {
          bottom_search = true, -- use a classic bottom cmdline for search
          command_palette = true, -- position the cmdline and popupmenu together
          long_message_to_split = true, -- long messages will be sent to a split
          inc_rename = false, -- enables an input dialog for inc-rename.nvim
          lsp_doc_border = false, -- add a border to hover docs and signature help
        },
      }
    end,
  },
  {
    'j-hui/fidget.nvim',
    event = 'BufReadPre',
    enabled = true,
    opts = {},
  },
  {
    'rcarriga/nvim-notify',
    enabled = false,
    config = function()
      require('notify').setup {
        background_colour = '#000000',
        stages = 'fade',
        timeout = 1500,
        top_down = true,
        max_width = 60,
        render = 'wrapped-compact',
        level = 'WARN',
      }

      local telescope = require 'telescope'

      telescope.load_extension 'notify'

      vim.keymap.set('n', '<leader>sn', telescope.extensions.notify.notify, {
        desc = '[S]earch [N]otifications',
      })
    end,
  },
}
