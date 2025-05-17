return {
  'stevearc/conform.nvim',
  event = {
    'BufWritePost',
    'DirChanged',
  },
  cmd = { 'ConformFormat', 'ConformInfo' },
  config = function()
    local h = require 'helpers.general'

    function setup()
      local js_ts_formatters = h.first {
        -- two under one require config means it's preferable to use both
        h.require_config { 'prettierd', 'eslint_d' },
        h.require_config 'deno_fmt',
        'biome', -- fallback (important to add to ensure_installed in mason-tool-installer)
      }

      local json_formatters = h.first {
        h.require_config 'biome',
        'prettierd',
      }

      ---@module "conform"
      ---@type conform.setupOpts
      local opts = {
        log_level = vim.log.levels.DEBUG,
        format_after_save = {
          timeout_ms = 100000,
          lsp_format = 'fallback',
          quiet = true, --- NOTE: maybe dangerous?
        },
        formatters_by_ft = {
          sh = { 'shfmt' },
          css = { 'prettierd' },
          elixir = { 'mix' },
          graphql = { 'prettierd' },
          html = { 'prettierd' },
          javascript = js_ts_formatters,
          javascriptreact = js_ts_formatters,
          json = json_formatters,
          jsonc = json_formatters,
          lua = { 'stylua' },
          markdown = { 'prettierd', 'injected' },
          mdx = { 'prettierd', 'injected' },
          python = { 'black' },
          svelte = h.first { h.require_config 'prettierd', 'biome' },
          typescript = js_ts_formatters,
          typescriptreact = js_ts_formatters,
          yaml = { 'prettierd' },
        },
      }
      require('conform').setup(opts)
    end

    vim.api.nvim_create_autocmd('DirChanged', {
      group = vim.api.nvim_create_augroup('ConformDirChanged', {
        clear = true,
      }),
      callback = setup,
    })

    vim.api.nvim_create_user_command('ConformFormat', function()
      require('conform').format()
    end, { desc = 'Format current buffer with Conform' })

    setup()
  end,
}
