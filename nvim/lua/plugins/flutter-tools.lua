return {
  'akinsho/flutter-tools.nvim',
  enabled = true,
  ft = { 'dart' },
  dependencies = {
    'nvim-lua/plenary.nvim',
    'stevearc/dressing.nvim',
  },
  config = function()
    local telescope = require 'telescope.builtin'

    require('flutter-tools').setup {
      ui = {
        border = 'rounded',
        notification_style = 'native',
      },
      decorations = {
        statusline = {
          -- set to true to be able use the 'flutter_tools_decorations.app_version' in your statusline
          -- this will show the current version of the flutter app from the pubspec.yaml file
          app_version = true,
          -- set to true to be able use the 'flutter_tools_decorations.device' in your statusline
          -- this will show the currently running device if an application was started with a specific
          -- device
          device = true,
          -- set to true to be able use the 'flutter_tools_decorations.project_config' in your statusline
          -- this will show the currently selected project configuration
          project_config = true,
        },
      },
      debugger = { -- integrate with nvim dap + install dart code debugger
        enabled = false,
        run_via_dap = false, -- use dap instead of a plenary job to run flutter apps
        -- if empty dap will not stop on any exceptions, otherwise it will stop on those specified
        -- see |:help dap.set_exception_breakpoints()| for more info
        exception_breakpoints = {},
      },
      root_patterns = { '.git', 'pubspec.yaml' }, -- patterns to find the root of your flutter project
      fvm = true, -- takes priority over path, uses <workspace>/.fvm/flutter_sdk if enabled
      widget_guides = {
        enabled = true,
      },
      closing_tags = {
        highlight = 'Comment', -- highlight for the closing tag
        prefix = '//', -- character to use for close tag e.g. > Widget
        enabled = true, -- set to false to disable
      },
      dev_log = {
        enabled = true,
        notify_errors = false, -- if there is an error whilst running then notify the user
        open_cmd = 'tabedit', -- command to us
      },
      dev_tools = {
        autostart = false, -- autostart devtools server if not detected
        auto_open_browser = false, -- Automatically opens devtools in the browser
      },
      outline = {
        open_cmd = '30vnew', -- command to use to open the outline buffer
        auto_open = false, -- if true this will open the outline automatically when it is first populated
      },
      lsp = {
        color = { -- show the derived colours for dart variables
          enabled = false, -- whether or not to highlight color variables at all, only supported on flutter >= 2.10
          background = false, -- highlight the background
          background_color = nil, -- required, when background is transparent (i.e. background_color = { r = 19, g = 17, b = 24},)
          foreground = false, -- highlight the foreground
          virtual_text = true, -- show the highlight using virtual text
          virtual_text_str = '■', -- the virtual text character to highlight
        },
        on_attach = function(client, bufnr)
          local nmap = function(keys, func, desc)
            if desc then
              desc = 'LSP: ' .. desc
            end

            vim.keymap.set('n', keys, func, { buffer = bufnr, desc = desc })
          end

          nmap('<leader>rn', vim.lsp.buf.rename, 'Rename')
          nmap('<leader>ca', vim.lsp.buf.code_action, 'Code Action')

          nmap('gd', telescope.lsp_definitions, 'Goto Definition')
          nmap('gr', telescope.lsp_references, 'Goto References')
          nmap('gI', telescope.lsp_implementations, 'Goto Implementation')
          nmap('<leader>D', telescope.lsp_type_definitions, 'Type Definition')
          nmap('<leader>ss', telescope.lsp_document_symbols, 'Document Symbols')
          nmap(
            '<leader>ws',
            telescope.lsp_dynamic_workspace_symbols,
            'Workspace Symbols'
          )

          -- See `:help K` for why this keymap
          nmap('K', vim.lsp.buf.hover, 'Hover Documentation')
          nmap('<C-k>', vim.lsp.buf.signature_help, 'Signature Documentation')

          -- Lesser used LSP functionality
          nmap('gD', vim.lsp.buf.declaration, 'Goto Declaration')
          nmap(
            '<leader>wa',
            vim.lsp.buf.add_workspace_folder,
            'Workspace Add Folder'
          )
          nmap(
            '<leader>wr',
            vim.lsp.buf.remove_workspace_folder,
            'Workspace Remove Folder'
          )
          nmap('<leader>wl', function()
            print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
          end, 'Workspace List Folders')

          -- Create a command `:Format` local to the LSP buffer
          vim.api.nvim_buf_create_user_command(bufnr, 'Format', function(_)
            vim.lsp.buf.format()
          end, { desc = 'Format current buffer with LSP' })
        end,
        capabilities = function(config)
          return config
        end,
        analysisExcludedFolders = { './fvm/' },
        -- see the link below for details on each option:
        -- https://github.com/dart-lang/sdk/blob/master/pkg/analysis_server/tool/lsp_spec/README.md#client-workspace-configuration
        settings = {
          showTodos = true,
          completeFunctionCalls = true,
          renameFilesWithClasses = 'prompt', -- "always"
          enableSnippets = true,
          updateImportsOnRename = true, -- Whether to update imports and other directives when files are renamed. Required for `FlutterRename` command.
        },
      },
    }

    require('telescope').load_extension 'flutter'

    local flutter_group = vim.api.nvim_create_augroup('FlutterTools', {
      clear = true,
    })

    vim.api.nvim_create_autocmd('BufEnter', {
      pattern = { '*.dart' },
      callback = function()
        vim.keymap.set(
          'n',
          '<leader>fr',
          '<cmd>FlutterRun<cr>',
          { desc = 'Flutter Run' }
        )
        vim.keymap.set('n', '<leader>ft', function()
          require('telescope').extensions.flutter.commands()
        end, { desc = 'Flutter Tools' })
      end,
      group = flutter_group,
    })
  end,
}
