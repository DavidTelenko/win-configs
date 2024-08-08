return {
  {
    'zbirenbaum/copilot.lua',
    enabled = true,
    event = 'InsertEnter',
    opts = {
      panel = {
        enabled = false,
      },
      suggestion = {
        enabled = false,
      },
      filetypes = {
        yaml = false,
        markdown = false,
        help = false,
        gitcommit = false,
        gitrebase = false,
        hgcommit = false,
        svn = false,
        cvs = false,
        ['.'] = false,
      },
    },
    config = function(_, opts)
      require('copilot').setup(opts)

      local enabled = true
      require('copilot.suggestion').toggle_auto_trigger()

      vim.keymap.set('n', '<leader>ct', function()
        require('copilot.suggestion').toggle_auto_trigger()

        enabled = not enabled

        local msg = 'Copilot suggestion auto trigger: ['
        print(msg .. (enabled and 'enabled' or 'disabled') .. ']')
      end, { desc = '[C]opilot [T]tirgger auto suggestion' })
    end,
  },
  {
    'nvim-cmp',
    event = 'InsertEnter',
    dependencies = {
      {
        'zbirenbaum/copilot-cmp',
        dependencies = 'copilot.lua',
        opts = {},
        config = function(_, opts)
          local copilot_cmp = require 'copilot_cmp'
          copilot_cmp.setup(opts)

          vim.api.nvim_create_autocmd('LspAttach', {
            callback = function()
              copilot_cmp._on_insert_enter {}
            end,
          })

          vim.api.nvim_set_hl(0, 'CmpItemKindCopilot', { fg = '#6CC644' })
        end,
      },
    },
    opts = function(_, opts)
      table.insert(opts.sources, 1, {
        name = 'copilot',
        group_index = 1,
        priority = 100,
      })
    end,
  },
}
