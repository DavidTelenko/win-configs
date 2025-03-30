return {
  {
    'neovim/nvim-lspconfig',
    event = 'VeryLazy',
    dependencies = {
      {
        'williamboman/mason.nvim',
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
      {
        'williamboman/mason-lspconfig.nvim',
        opts = {},
      },
      -- Additional lua configuration, makes nvim stuff amazing!
      {
        'folke/lazydev.nvim',
        ft = 'lua',
        opts = {},
      },
      'tpope/vim-sleuth',
      'b0o/schemastore.nvim',
      'yioneko/nvim-vtsls',
    },
    config = function()
      local telescope = require 'telescope.builtin'

      vim.keymap.set('n', '<leader>cI', function()
        vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled {})
      end, { desc = 'Enable [I]nline hints' })

      vim.keymap.set('n', '<leader>cd', vim.diagnostic.setqflist, {
        desc = 'Open diagnostics list',
      })

      vim.keymap.set('n', ']d', function()
        vim.diagnostic.jump { count = 1, float = true }
      end, { desc = 'Go to next diagnostic message' })

      vim.keymap.set('n', '[d', function()
        vim.diagnostic.jump { count = -1, float = true }
      end, { desc = 'Go to prev diagnostic message' })

      vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, {
        desc = 'Open floating diagnostic message',
      })

      vim.diagnostic.config {
        float = { border = 'rounded' },
        virtual_text = {
          current_line = true,
        },
      }

      --  This function gets run when an LSP connects to a particular buffer.
      local on_attach = function(client, bufnr)
        local nmap = function(keys, func, desc)
          if desc then
            desc = 'LSP: ' .. desc
          end

          vim.keymap.set('n', keys, func, { buffer = bufnr, desc = desc })
        end

        nmap('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')
        nmap('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction')

        nmap('gd', telescope.lsp_definitions, '[G]oto [D]efinition')
        nmap('gr', telescope.lsp_references, '[G]oto [R]eferences')
        nmap('gI', telescope.lsp_implementations, '[G]oto [I]mplementation')

        nmap('<leader>D', telescope.lsp_type_definitions, 'Type [D]efinition')
        nmap(
          '<leader>ss',
          telescope.lsp_document_symbols,
          '[D]ocument [S]ymbols'
        )
        nmap(
          '<leader>ws',
          telescope.lsp_dynamic_workspace_symbols,
          '[W]orkspace [S]ymbols'
        )

        -- See `:help K` for why this keymap
        nmap('K', function()
          vim.lsp.buf.hover { border = 'rounded' }
        end, 'Hover Documentation')

        nmap('<C-k>', function()
          vim.lsp.buf.signature_help { border = 'rounded' }
        end, 'Signature Documentation')

        -- Lesser used LSP functionality
        nmap('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')
        nmap(
          '<leader>wa',
          vim.lsp.buf.add_workspace_folder,
          '[W]orkspace [A]dd Folder'
        )
        nmap(
          '<leader>wr',
          vim.lsp.buf.remove_workspace_folder,
          '[W]orkspace [R]emove Folder'
        )
        nmap('<leader>wl', function()
          print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
        end, '[W]orkspace [L]ist Folders')

        vim.api.nvim_buf_create_user_command(bufnr, 'Format', function()
          vim.lsp.buf.format()
        end, { desc = 'Format current buffer with LSP' })
      end

      local schemas = require 'schemastore'

      local servers = {
        -- jdtls = {},         -- java
        -- ols = {},           -- odin
        -- pyright = {},       -- python
        html = { filetypes = { 'html', 'twig', 'hbs' } },
        elixirls = {},
        clangd = {},
        emmet_language_server = {},
        gopls = {},
        lua_ls = {
          Lua = {
            workspace = { checkThirdParty = false },
            telemetry = { enable = false },
            diagnostics = { disable = { 'missing-fields' } },
          },
        },
        rust_analyzer = {},
        svelte = {},
        tailwindcss = {},
        vtsls = {},
        jsonls = {
          schemas = schemas.json.schemas(),
          validate = { enable = true },
        },
        yamlls = {
          schemas = schemas.yaml.schemas(),
          schemaStore = {
            enable = false,
            url = '',
          },
        },
      }

      -- nvim-cmp supports additional completion capabilities, so broadcast that to servers
      local capabilities = vim.lsp.protocol.make_client_capabilities()
      capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

      -- Ensure the servers above are installed
      local mason_lspconfig = require 'mason-lspconfig'

      mason_lspconfig.setup {
        ensure_installed = vim.tbl_keys(servers),
      }

      mason_lspconfig.setup_handlers {
        function(server_name)
          require('lspconfig')[server_name].setup {
            capabilities = capabilities,
            on_attach = on_attach,
            settings = servers[server_name],
            filetypes = (servers[server_name] or {}).filetypes,
          }
        end,
      }
    end,
  },
}
