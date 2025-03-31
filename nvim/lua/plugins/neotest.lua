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
  },
  keys = {
    { '<leader>tr', '<cmd>Neotest run <cr>', desc = '[R]un nearest test' },
    { '<leader>tl', '<cmd>Neotest run last<cr>', desc = 'Run [L]ast test' },
    { '<leader>tf', '<cmd>Neotest run file<cr>', desc = 'Run test [F]ile' },
    {
      '<leader>tt',
      '<cmd>Neotest run output-panel<cr>',
      desc = '[T]oggle ouput panel',
    },
  },
  config = function()
    require('neotest').setup {
      adapters = {
        -- TODO: think of a portable way to compose a jestCommand
        require 'neotest-jest' {
          jestCommand = 'yarn nx test ',
          jestConfigFile = 'jest.config.ts',
          cwd = function()
            return vim.fn.getcwd()
          end,
        },
      },
      output_panel = { open_on_run = true },
      diagnostic = { enabled = true },
    }
  end,
}
