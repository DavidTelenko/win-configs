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
      javascript = { 'eslint_d', 'biomejs' },
      typescript = { 'eslint_d', 'biomejs' },
      javascriptreact = { 'eslint_d', 'biomejs' },
      typescriptreact = { 'eslint_d', 'biomejs' },
      svelte = { 'eslint_d' },
      python = { 'pylint' },
      cpp = { 'cpplint' },
    }

    local formatters_by_ft = {
      javascript = { 'prettier', 'biome', 'deno_fmt' },
      typescript = { 'prettier', 'biome', 'deno_fmt' },
      javascriptreact = { 'prettier', 'biome', 'deno_fmt' },
      typescriptreact = { 'prettier', 'biome', 'deno_fmt' },
      svelte = { 'prettier' },
      css = { 'prettier' },
      html = { 'prettier' },
      json = { 'prettier', 'biome' },
      yaml = { 'prettier' },
      markdown = { 'prettier' },
      graphql = { 'prettier' },
      lua = { 'stylua' },
      python = { 'black' },
    }

    conform.setup {
      log_level = vim.log.levels.DEBUG,
      formatters_by_ft = formatters_by_ft,
    }

    lint.linters_by_ft = linters_by_ft

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
      local current_dir = vim.fn.expand '%:p:h'
      local home_dir = vim.fn.expand '$HOME'

      while current_dir ~= home_dir and current_dir ~= '/' do
        for formatter, patterns in pairs(config_files) do
          for _, pattern in ipairs(patterns) do
            local config_file = current_dir .. '/' .. pattern
            if vim.fn.filereadable(config_file) == 1 then
              return formatter
            end
          end
        end
        current_dir = vim.fn.fnamemodify(current_dir, ':h')
      end
      return nil
    end

    -- Function to determine the formatter based on config files and file type
    local function get_formatter()
      local filetype = vim.bo.filetype
      local available_formatters = formatters_by_ft[filetype] or {}
      local formatter = find_first_config_from(formatter_configs)

      if formatter then
        if
          formatter == 'prettier'
          and vim.tbl_contains(available_formatters, 'prettier')
        then
          vim.g.current_formatter = 'prettier'
          return { 'prettier' }
        elseif
          formatter == 'biome'
          and vim.tbl_contains(available_formatters, 'biome')
        then
          vim.g.current_formatter = 'biome'
          return { 'biome' }
        elseif
          formatter == 'deno'
          and vim.tbl_contains(available_formatters, 'deno_fmt')
        then
          vim.g.current_formatter = 'deno_fmt'
          return { 'deno_fmt' }
        end
      end

      -- Default to the first available formatter for the file type, or prettier if none specified
      vim.g.current_formatter = available_formatters[1] or 'prettier'
      return { vim.g.current_formatter }
    end

    local function get_linter()
      local filetype = vim.bo.filetype
      local available_linter = linters_by_ft[filetype] or {}
      local linter = find_first_config_from(linter_configs)

      if linter then
        if
          linter == 'eslint'
          and vim.tbl_contains(available_linter, 'eslint_d')
        then
          vim.g.current_linter = 'eslint'
          return { 'eslint' }
        elseif
          linter == 'biome'
          and vim.tbl_contains(available_linter, 'biome')
        then
          vim.g.current_linter = 'biome'
          return { 'biome' }
        end
      end

      -- Default to the first available formatter for the file type, or prettier if none specified
      vim.g.current_linter = available_linter[1]
      return { vim.g.current_linter }
    end

    -- Format auto command
    vim.api.nvim_create_autocmd({ 'BufWritePost' }, {
      callback = function(args)
        conform.format {
          formatters = get_formatter(),
          bufnr = args.buf,
          lsp_fallback = true,
          async = true,
          timeout_ms = 100000,
        }
      end,
    })

    -- Lint auto command
    vim.api.nvim_create_autocmd({ 'BufEnter', 'BufWritePost', 'InsertLeave' }, {
      callback = function()
        lint.try_lint(get_linter())
      end,
    })
  end,
}
