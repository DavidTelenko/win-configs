return {
  'mfussenegger/nvim-dap',
  event = 'BufReadPre',
  dependencies = {
    -- Creates a beautiful debugger UI
    'rcarriga/nvim-dap-ui',
    'theHamsta/nvim-dap-virtual-text',

    -- Installs the debug adapters for you
    'williamboman/mason.nvim',
    'jay-babu/mason-nvim-dap.nvim',
    'nvim-neotest/neotest',
    'nvim-neotest/nvim-nio',
  },
  config = function()
    local dap = require 'dap'
    local dapui = require 'dapui'

    require('mason-nvim-dap').setup {
      -- Makes a best effort to setup the various debuggers with
      -- reasonable debug configurations
      automatic_setup = true,
      automatic_installation = true,

      -- You can provide additional configuration to the handlers,
      -- see mason-nvim-dap README for more information
      handlers = {
        function(config)
          if vim.fn.has 'win32' == 1 then
            config.adapters.executable.detached = false
          end
          require('mason-nvim-dap').default_setup(config)
        end,

        cppdbg = function(config)
          if vim.fn.has 'win32' == 1 then
            config.adapters['command'] = vim.fn.stdpath 'data'
              .. '/mason/bin/OpenDebugAD7.cmd'
          end
          require('mason-nvim-dap').default_setup(config)
        end,

        python = function(config)
          config.adapters = {
            type = 'executable',
            command = 'python',
            args = {
              '-m',
              'debugpy.adapter',
            },
          }
          config.configurations = {
            {
              type = 'python',
              request = 'launch',
              name = 'Python: Launch file',
              program = '${file}',
              pythonPath = function()
                return vim.fn.exepath 'python'
              end,
              console = 'integratedTerminal',
            },
          }
          require('mason-nvim-dap').default_setup(config)
        end,
      },

      -- You'll need to check that you have the required things installed
      -- online, please don't ask me how to install them :)
      ensure_installed = {
        -- Update this to ensure that you have the debuggers for the langs you want
        -- 'cppdbg',
        -- 'python',
        -- 'delve',
      },
    }

    vim.keymap.set('n', '<leader>di', dap.step_into, { desc = 'Step [I]nto' })
    vim.keymap.set('n', '<leader>do', dap.step_over, { desc = 'Step [O]ver' })
    vim.keymap.set('n', '<leader>dO', dap.step_out, { desc = 'Step [O]ut' })
    vim.keymap.set(
      'n',
      '<leader>dc',
      dap.continue,
      { desc = 'Start/[C]ontinue' }
    )
    vim.keymap.set(
      'n',
      '<leader>db',
      dap.toggle_breakpoint,
      { desc = 'Toggle [B]reakpoint' }
    )
    vim.keymap.set('n', '<leader>dB', function()
      dap.set_breakpoint(vim.fn.input 'Breakpoint condition: ')
    end, { desc = 'Set [B]reakpoint' })

    -- Dap UI setup
    -- For more information, see |:help nvim-dap-ui|
    dapui.setup()
    require('nvim-dap-virtual-text').setup {}

    vim.api.nvim_set_hl(
      0,
      'DapBreakpoint',
      { ctermbg = 0, fg = '#fb4934', bg = '#261c1c' }
    )
    vim.api.nvim_set_hl(
      0,
      'DapLogPoint',
      { ctermbg = 0, fg = '#83a598', bg = '#261c1c' }
    )
    vim.api.nvim_set_hl(
      0,
      'DapStopped',
      { ctermbg = 0, fg = '#fb4934', bg = '#261c1c' }
    )

    vim.fn.sign_define('DapBreakpoint', {
      text = '',
      texthl = 'DapBreakpoint',
      linehl = 'DapBreakpoint',
      numhl = 'DapBreakpoint',
    })
    vim.fn.sign_define('DapBreakpointCondition', {
      text = '',
      texthl = 'DapBreakpoint',
      linehl = 'DapBreakpoint',
      numhl = 'DapBreakpoint',
    })
    vim.fn.sign_define('DapBreakpointRejected', {
      text = '',
      texthl = 'DapBreakpoint',
      linehl = 'DapBreakpoint',
      numhl = 'DapBreakpoint',
    })
    vim.fn.sign_define('DapLogPoint', {
      text = '',
      texthl = 'DapLogPoint',
      linehl = 'DapLogPoint',
      numhl = 'DapLogPoint',
    })
    vim.fn.sign_define('DapStopped', {
      text = '',
      texthl = 'DapStopped',
      linehl = 'DapStopped',
      numhl = 'DapStopped',
    })

    -- Toggle to see last session result. Without this, you can't see session output in case of unhandled exception.
    vim.keymap.set(
      'n',
      '<F7>',
      dapui.toggle,
      { desc = 'Debug: See last session result.' }
    )

    dap.listeners.after.event_initialized['dapui_config'] = dapui.open
    dap.listeners.before.event_terminated['dapui_config'] = dapui.close
    dap.listeners.before.event_exited['dapui_config'] = dapui.close
  end,
}
