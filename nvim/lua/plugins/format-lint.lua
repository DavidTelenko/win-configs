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

    --- NOTE: Here's the logic for you if you'll ever forget:
    ---
    --- !The rule of thumb: first ones listed using `first` are exotics which
    --- are not installed using Mason (the global "defaults"), latter ones is
    --- more and more global, the last one is preferably the one you've
    --- installed with mason
    ---
    --- !Also: if you install something with Mason it WILL BE FOUND anyway,
    --- because Mason adds the tool to the nvim Path so take this into
    --- consideration.
    local function first(bufnr, formatters)
      for _, formatter in ipairs(formatters) do
        if conform.get_formatter_info(formatter, bufnr).available then
          return formatter
        end
      end
      return formatters[1]
    end

    local function first_fmt(formatters)
      return function(bufnr)
        return { first(bufnr, formatters) }
      end
    end

    local js_ts_formatters = function(bufnr)
      local formatter = first(bufnr, { 'biome', 'deno_fmt', 'prettierd' })
      if formatter == 'prettierd' then
        return { formatter, 'eslint_d' }
      end
      return { formatter }
    end

    require('mason-tool-installer').setup {
      ensure_installed = {
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
        json = first_fmt { 'biome', 'prettierd' },
        lua = { 'stylua' },
        markdown = { 'prettierd' },
        mdx = { 'prettierd' },
        python = { 'black' },
        svelte = first_fmt { 'biome', 'prettierd' },
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

    local formatter = first(0, { 'biome', 'eslint_d' })
    local js_ts_linters = { formatter_to_linter[formatter] }

    lint.linters_by_ft = {
      cpp = { 'cpplint' },
      javascript = js_ts_linters,
      javascriptreact = js_ts_linters,
      python = { 'pylint' },
      svelte = { 'eslint_d' },
      typescript = js_ts_linters,
      typescriptreact = js_ts_linters,
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
