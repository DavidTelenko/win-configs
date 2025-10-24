---@return table<string,vim.lsp.Config>
local get_servers = function(context)
  return {
    ols = {},
    bashls = {},
    pyright = {},
    html = {
      filetypes = {
        'html',
        'twig',
        'hbs',
      },
    },
    elixirls = {
      cmd = { 'elixir-ls' },
    },
    clangd = {},
    emmet_language_server = {},
    gopls = {},
    jdtls = {
      -- TODO: I may want to use JDTLS_JVM_ARGS env var instead
      cmd = vim.list_extend(
        vim.lsp.config['jdtls'].cmd, ---@diagnostic disable-line: param-type-mismatch
        {
          '--jvm-arg=-javaagent:'
            .. vim.fn.expand '$MASON/share/jdtls/lombok.jar',
        }
      ),
    },
    lua_ls = {
      settings = {
        Lua = {
          hint = { enable = true },
          workspace = {
            checkThirdParty = false,
          },
          telemetry = {
            enable = false,
          },
          diagnostics = {
            disable = {
              'missing-fields',
              'unused-function', -- unused name will still be reported
            },
          },
        },
      },
    },
    rust_analyzer = {},
    svelte = {},
    tailwindcss = {},
    ts_ls = {
      settings = {
        typescript = {
          inlayHints = {
            includeInlayParameterNameHints = 'all',
            includeInlayParameterNameHintsWhenArgumentMatchesName = false,
            includeInlayFunctionParameterTypeHints = true,
            includeInlayVariableTypeHints = true,
            includeInlayPropertyDeclarationTypeHints = true,
            includeInlayFunctionLikeReturnTypeHints = true,
            includeInlayEnumMemberValueHints = true,
          },
        },
      },
    },
    -- kotlin_language_server = {},
    -- vtsls = {},
    jsonls = {
      settings = {
        json = {
          schemas = context.schemas.json.schemas(),
          validate = {
            enable = true,
          },
        },
      },
    },
    yamlls = {
      settings = {
        yaml = {
          schemas = context.schemas.yaml.schemas(),
          schemaStore = {
            enable = false,
            url = '',
          },
        },
      },
    },
    zls = {},
  }
end

return {
  {
    'yioneko/nvim-vtsls',
    enabled = false,
    ft = { 'typescript', 'javascript', 'typescriptreact', 'javascriptreact' },
    opts = {},
  },
  {
    'folke/lazydev.nvim',
    ft = 'lua',
    opts = {},
  },
  {
    'WhoIsSethDaniel/mason-tool-installer.nvim',
    event = 'VeryLazy',
    opts = {
      ensure_installed = {
        'biome',
        'eslint_d',
        'prettierd',
        'shfmt',
        'stylua',
        'yq',
      },
    },
  },
  {
    'williamboman/mason.nvim',
    event = 'VeryLazy',
    ---@type MasonSettings
    opts = {
      log_level = vim.log.levels.INFO,
      max_concurrent_installers = 4,
      registries = {
        'github:mason-org/mason-registry',
      },
      providers = {
        'mason.providers.registry-api',
        'mason.providers.client',
      },
      github = {
        download_url_template = 'https://github.com/%s/releases/download/%s/%s',
      },
      pip = {
        upgrade_pip = false,
        install_args = {},
      },
      ui = {
        check_outdated_packages_on_open = true,
        border = 'rounded',
        width = 0.8,
        height = 0.8,
        icons = {
          package_installed = '',
          package_pending = '⌛',
          package_uninstalled = '',
        },
        keymaps = {
          toggle_package_expand = '<CR>',
          install_package = 'i',
          update_package = 'u',
          check_package_version = 'c',
          update_all_packages = 'U',
          check_outdated_packages = 'C',
          uninstall_package = 'X',
          cancel_installation = '<C-c>',
          apply_language_filter = '<C-f>',
          toggle_package_install_log = '<CR>',
          toggle_help = 'g?',
        },
      },
    },
  },
  { 'williamboman/mason-lspconfig.nvim' },
  { 'b0o/schemastore.nvim' },
  { 'danarth/sonarlint.nvim' },
  {
    'neovim/nvim-lspconfig',
    event = 'VeryLazy',
    config = function()
      local telescope = require 'telescope.builtin'
      local mason_lspconfig = require 'mason-lspconfig'
      local helpers = require 'helpers.lsp'

      vim.keymap.set('n', '<leader>cI', function()
        vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled {})
      end, { desc = 'Enable Inline hints' })

      vim.keymap.set('n', '<leader>cd', vim.diagnostic.setqflist, {
        desc = 'Open diagnostics list',
      })

      helpers.next_prev_diagnostic {
        severity = vim.diagnostic.severity.ERROR,
        key = 'e',
        message = 'error',
      }
      helpers.next_prev_diagnostic {
        severity = vim.diagnostic.severity.WARN,
        key = 'w',
        message = 'warning',
      }
      helpers.next_prev_diagnostic {
        severity = nil,
        key = 'd',
        message = 'diagnostic',
      }

      vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, {
        desc = 'Open floating diagnostic message',
      })

      vim.keymap.set('n', '<leader>cR', '<cmd>LspRestart<cr>', {
        desc = 'Restart Lsp Server',
      })

      vim.diagnostic.config {
        float = { border = 'rounded', source = 'if_many' },
        signs = {
          text = {
            [vim.diagnostic.severity.ERROR] = '󰅚 ',
            [vim.diagnostic.severity.WARN] = '󰀪 ',
            [vim.diagnostic.severity.INFO] = '󰋽 ',
            [vim.diagnostic.severity.HINT] = '󰌶 ',
          },
        },
        virtual_text = {
          current_line = true,
        },
      }

      --  This function gets run when an LSP connects to a particular buffer.
      local on_attach = function(_, buf)
        local nmap = function(keys, func, desc)
          if desc then
            desc = 'LSP: ' .. desc
          end

          vim.keymap.set('n', keys, func, { buffer = buf, desc = desc })
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

        nmap('K', function()
          vim.lsp.buf.hover { border = 'rounded' }
        end, 'Hover Documentation')

        nmap('gK', function()
          vim.lsp.buf.signature_help { border = 'rounded' }
        end, 'Signature Documentation')

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

        vim.api.nvim_buf_create_user_command(buf, 'LspFormat', function()
          vim.lsp.buf.format()
        end, { desc = 'Format current buffer with LSP' })
      end

      -- nvim-cmp supports additional completion capabilities, so broadcast that to servers
      local capabilities = vim.lsp.protocol.make_client_capabilities()
      capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

      local servers = get_servers {
        schemas = require 'schemastore',
      }

      -- Ensure the servers above are installed

      ---@type MasonLspconfigSettings
      mason_lspconfig.setup {
        ensure_installed = vim.tbl_keys(servers),
        automatic_enable = false,
      }

      ---@type table<string,vim.lsp.Config>
      local local_servers = {
        nushell = {},
      }

      ---@type table<string,vim.lsp.Config>
      local all_servers = vim.tbl_extend('error', servers, local_servers)

      for name, config in pairs(all_servers) do
        vim.lsp.enable(name)
        vim.lsp.config(
          name,
          vim.tbl_deep_extend('force', vim.lsp.config[name], config, {
            on_attach = on_attach,
            capabilities = capabilities,
          })
        )
      end
    end,
  },
}
