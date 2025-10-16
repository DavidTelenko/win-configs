return {
  'nvim-neotest/neotest',
  -- TODO: enable when either treesitter or neotest-jest gets updated
  enabled = false,
  dependencies = {
    'nvim-neotest/nvim-nio',
    'nvim-lua/plenary.nvim',
    'nvim-treesitter/nvim-treesitter',
    -- Adapters
    'nvim-neotest/neotest-jest',
    'thenbe/neotest-playwright',
  },
  keys = {
    { '<leader>Tr', '<cmd>Neotest run <cr>', desc = 'Run nearest test' },
    { '<leader>Tl', '<cmd>Neotest run last<cr>', desc = 'Run Last test' },
    { '<leader>Tf', '<cmd>Neotest run file<cr>', desc = 'Run test File' },
    {
      '<leader>Tt',
      '<cmd>Neotest run output-panel<cr>',
      desc = 'Toggle ouput panel',
    },
  },
  opts = function()
    return {
      adapters = {
        -- TODO: think of a portable way to compose a jestCommand
        require 'neotest-jest' {
          jestCommand = 'yarn nx test ',
          jestConfigFile = 'jest.config.ts',
          cwd = function()
            return vim.fn.getcwd()
          end,
        },
        require('neotest-playwright').adapter {
          options = {
            persist_project_selection = true,
            enable_dynamic_test_discovery = true,
            preset = 'debug',
            experimental = {
              telescope = {
                enabled = true,
                opts = {},
              },
            },
          },
        },
      },
      output_panel = { open_on_run = true },
      diagnostic = { enabled = true },
    }
  end,
}
