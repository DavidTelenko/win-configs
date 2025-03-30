return {
  'mfussenegger/nvim-lint',
  dependencies = {
    'stevearc/conform.nvim',
    'WhoIsSethDaniel/mason-tool-installer.nvim',
  },
  event = {
    'BufReadPre',
    'BufNewFile',
  },
  config = function()
    local conform = require 'conform'

    local function first(bufnr, ...)
      for i = 1, select('#', ...) do
        local formatter = select(i, ...)
        if conform.get_formatter_info(formatter, bufnr).available then
          return formatter
        end
      end
      return select(1, ...)
    end

    local js_ts_formatters = function(bufnr)
      return {
        first(bufnr, 'biome', 'deno_fmt', 'prettierd'),
        'eslint_d',
      }
    end

    require('mason-tool-installer').setup {
      ensure_installed = {
        'biome',
        'eslint_d',
        'prettierd',
        'stylua',
      },
    }

    conform.setup {
      log_level = vim.log.levels.DEBUG,
      format_after_save = {
        lsp_fallback = true,
        timeout_ms = 100000,
      },
      formatters_by_ft = {
        css = { 'prettierd' },
        elixir = { 'mix' },
        graphql = { 'prettierd' },
        html = { 'prettierd' },
        javascript = js_ts_formatters,
        javascriptreact = js_ts_formatters,
        json = { 'prettierd', 'biome' },
        lua = { 'stylua' },
        markdown = { 'prettierd' },
        mdx = { 'prettierd' },
        python = { 'black' },
        svelte = { 'prettierd', 'biome' },
        typescript = js_ts_formatters,
        typescriptreact = js_ts_formatters,
        yaml = { 'prettierd' },
      },
    }

    local lint = require 'lint'
    local formatter_to_linter = {
      biome = 'biomejs',
      eslint_d = 'eslint_d',
    }

    local js_ts_linters = function(bufnr)
      local formatter = first(bufnr, 'biome', 'eslint_d')
      return { formatter_to_linter[formatter] }
    end

    lint.linters_by_ft = {
      cpp = { 'cpplint' },
      javascript = js_ts_linters(),
      javascriptreact = js_ts_linters(),
      python = { 'pylint' },
      svelte = { 'eslint_d' },
      typescript = js_ts_linters(),
      typescriptreact = js_ts_linters(),
    }

    -- Lint auto command
    vim.api.nvim_create_autocmd({ 'BufEnter', 'BufWritePost', 'InsertLeave' }, {
      callback = function(args)
        local buftype =
          vim.api.nvim_get_option_value('buftype', { buf = args.buf })

        if buftype == '' then
          lint.try_lint()
          lint.try_lint 'cspell'
        end
      end,
    })
  end,
}
