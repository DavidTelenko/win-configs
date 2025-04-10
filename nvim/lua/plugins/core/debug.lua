return {
  'mfussenegger/nvim-dap',
  keys = {
    { '<leader>du', desc = 'Open Ui' },
    { '<leader>dB', desc = 'Set Breakpoint' },
    { '<leader>db', desc = 'Toggle Breakpoint' },
    { '<leader>dc', desc = 'Start/Continue' },
    { '<leader>dO', desc = 'Step Out' },
    { '<leader>do', desc = 'Step Over' },
    { '<leader>di', desc = 'Step Into' },
  },
  dependencies = {
    -- Creates a beautiful debugger UI
    'rcarriga/nvim-dap-ui',
    'theHamsta/nvim-dap-virtual-text',
    'jay-babu/mason-nvim-dap.nvim',
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
            pcall(function()
              config.adapters.executable.detached = false
            end)
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

    vim.keymap.set('n', '<leader>di', dap.step_into, {
      desc = 'Step Into',
    })

    vim.keymap.set('n', '<leader>do', dap.step_over, {
      desc = 'Step Over',
    })

    vim.keymap.set('n', '<leader>dO', dap.step_out, {
      desc = 'Step Out',
    })

    vim.keymap.set('n', '<leader>dc', dap.continue, {
      desc = 'Start/Continue',
    })

    vim.keymap.set('n', '<leader>db', dap.toggle_breakpoint, {
      desc = 'Toggle Breakpoint',
    })

    vim.keymap.set('n', '<leader>dB', function()
      dap.set_breakpoint(vim.fn.input 'Breakpoint condition: ')
    end, { desc = 'Set Breakpoint' })

    -- Toggle to see last session result. Without this, you can't see session output in case of unhandled exception.
    vim.keymap.set('n', '<leader>du', dapui.toggle, {
      desc = 'Open Ui',
    })

    -- Dap UI setup
    -- For more information, see |:help nvim-dap-ui|
    dapui.setup()
    require('nvim-dap-virtual-text').setup {}

    vim.api.nvim_set_hl(0, 'DapBreakpoint', {
      ctermbg = 0,
      fg = '#fb4934',
      bg = '#261c1c',
    })

    vim.api.nvim_set_hl(0, 'DapLogPoint', {
      ctermbg = 0,
      fg = '#83a598',
      bg = '#261c1c',
    })

    vim.api.nvim_set_hl(0, 'DapStopped', {
      ctermbg = 0,
      fg = '#fb4934',
      bg = '#261c1c',
    })

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

    dap.listeners.after.event_initialized['dapui_config'] = dapui.open
    dap.listeners.before.event_terminated['dapui_config'] = dapui.close
    dap.listeners.before.event_exited['dapui_config'] = dapui.close
  end,
}
