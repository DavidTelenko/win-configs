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

    --- TODO: starting from this point make this configuration modular
    local eslint_configs = {
      'eslint.config.js',
      'eslint.config.mjs',
      'eslint.config.cjs',
      'eslint.config.ts',
      'eslint.config.mts',
      'eslint.config.cts',
    }
    local biome_configs = { 'biome.json', 'biome.jsonc' }

    local linters_configs = {
      biomejs = biome_configs,
      eslint_d = eslint_configs,
    }

    local formatter_configs = {
      biome = biome_configs,
      eslint_d = eslint_configs,
      prettierd = {
        '.prettierrc',
        '.prettierrc.json',
        '.prettierrc.js',
        'prettier.config.js',
        'prettier.config.mjs',
        'prettier.config.cjs',
      },
      deno = { 'deno.json', 'deno.jsonc' },
    }

    local function from_local_configs(config_files)
      local dir = vim.fn.getcwd()
      local result = {}
      for formatter, patterns in pairs(config_files) do
        for _, pattern in ipairs(patterns) do
          local config_file = dir .. '/' .. pattern
          if vim.fn.filereadable(config_file) == 1 then
            table.insert(result, formatter)
          end
        end
      end
      return result
    end

    local js_ts_formatters = function(bufnr)
      return from_local_configs(formatter_configs)
    end

    require('mason-tool-installer').setup {
      ensure_installed = {
        'biome',
        'eslint_d',
        'prettierd',
        'stylua',
        'yq',
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
    local js_ts_linters = from_local_configs(linters_configs)

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
