return {
  'stevearc/conform.nvim',
  dependencies = {
    'mfussenegger/nvim-lint',
  },
  event = {
    'BufReadPre',
    'BufNewFile',
  },
  config = function()
    local conform = require 'conform'
    local lint = require 'lint'

    vim.g.current_formatter = 'None'
    vim.g.current_linter = 'None'

    local linters_by_ft = {
      cpp = { 'cpplint' },
      javascript = { 'eslint_d', 'biomejs' },
      javascriptreact = { 'eslint_d', 'biomejs' },
      python = { 'pylint' },
      svelte = { 'eslint_d' },
      typescript = { 'eslint_d', 'biomejs' },
      typescriptreact = { 'eslint_d', 'biomejs' },
    }

    local formatters_by_ft = {
      css = { 'prettier' },
      elixir = { 'mix' },
      graphql = { 'prettier' },
      html = { 'prettier' },
      javascript = { 'prettier', 'biome', 'deno_fmt' },
      javascriptreact = { 'prettier', 'biome', 'deno_fmt' },
      json = { 'prettier', 'biome' },
      lua = { 'stylua' },
      markdown = { 'prettier' },
      mdx = { 'prettier' },
      python = { 'black' },
      svelte = { 'prettier', 'biome' },
      typescript = { 'prettier', 'biome', 'deno_fmt' },
      typescriptreact = { 'prettier', 'biome', 'deno_fmt' },
      yaml = { 'prettier' },
    }

    conform.setup {
      log_level = vim.log.levels.DEBUG,
      formatters_by_ft = formatters_by_ft,
    }

    -- Function to find the first config file by walking up the directory tree
    local formatter_configs = {
      prettier = {
        '.prettierrc',
        '.prettierrc.json',
        '.prettierrc.js',
        'prettier.config.js',
        'prettier.config.mjs',
        'prettier.config.cjs',
      },
      biome = { 'biome.json', 'biome.jsonc' },
      deno = { 'deno.json', 'deno.jsonc' },
    }

    local linter_configs = {
      biome = { 'biome.json', 'biome.jsonc' },
      deno = { 'deno.json', 'deno.jsonc' },
      eslint = {
        'eslint.config.js',
        'eslint.config.mjs',
        'eslint.config.cjs',
        'eslint.config.ts',
        'eslint.config.mts',
        'eslint.config.cts',
      },
    }

    local function find_first_config_from(config_files)
      local dir = vim.fn.getcwd()
      for formatter, patterns in pairs(config_files) do
        for _, pattern in ipairs(patterns) do
          local config_file = dir .. '/' .. pattern
          if vim.fn.filereadable(config_file) == 1 then
            return formatter
          end
        end
      end
      return nil
    end

    -- Function to determine the formatter based on config files and file type
    local function get_formatter()
      local filetype = vim.bo.filetype
      local available_formatters = formatters_by_ft[filetype] or {}
      local formatter = find_first_config_from(formatter_configs)

      vim.g.current_formatter = available_formatters[1]

      if
        formatter == 'prettier'
        and vim.tbl_contains(available_formatters, 'prettier')
      then
        vim.g.current_formatter = 'prettier'
      elseif
        formatter == 'biome'
        and vim.tbl_contains(available_formatters, 'biome')
      then
        vim.g.current_formatter = 'biome'
      elseif
        formatter == 'deno'
        and vim.tbl_contains(available_formatters, 'deno_fmt')
      then
        vim.g.current_formatter = 'deno_fmt'
      end

      return { vim.g.current_formatter }
    end

    local function get_linter()
      local filetype = vim.bo.filetype
      local available_linter = linters_by_ft[filetype] or {}
      local linter = find_first_config_from(linter_configs)

      vim.g.current_linter = available_linter[1]

      if
        linter == 'eslint'
        and vim.tbl_contains(available_linter, 'eslint')
      then
        vim.g.current_linter = 'eslint'
      elseif
        linter == 'biome'
        and vim.tbl_contains(available_linter, 'biomejs')
      then
        vim.g.current_linter = 'biomejs'
      end

      return { vim.g.current_linter }
    end

    -- Format auto command
    vim.api.nvim_create_autocmd({ 'BufWritePre' }, {
      callback = function(args)
        conform.format {
          formatters = get_formatter(),
          bufnr = args.buf,
          lsp_fallback = true,
          timeout_ms = 100000,
        }
      end,
    })

    -- Lint auto command
    vim.api.nvim_create_autocmd({ 'BufEnter', 'BufWritePost', 'InsertLeave' }, {
      callback = function(args)
        local buftype =
          vim.api.nvim_get_option_value('buftype', { buf = args.buf })

        if buftype == '' then
          lint.try_lint(get_linter())
          lint.try_lint 'cspell'
        end
      end,
    })
  end,
}
