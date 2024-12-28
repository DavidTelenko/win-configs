return {
  'stevearc/conform.nvim',
  event = {
    'BufReadPre',
    'BufNewFile',
  },
  config = function()
    local conform = require 'conform'

    conform.setup {
      log_level = vim.log.levels.DEBUG,
      formatters_by_ft = {
        javascript = { 'biome' },
        typescript = { 'biome' },
        javascriptreact = { 'biome' },
        typescriptreact = { 'biome' },
        svelte = { 'prettier' },
        css = { 'prettier' },
        html = { 'prettier' },
        json = { 'prettier' },
        yaml = { 'prettier' },
        markdown = { 'prettier' },
        graphql = { 'prettier' },
        lua = { 'stylua' },
        python = { 'black' },
      },
    }

    vim.api.nvim_create_autocmd({ 'BufWritePost' }, {
      group = vim.api.nvim_create_augroup('format', {
        clear = true,
      }),
      callback = function(args)
        conform.format {
          bufnr = args.buf,
          lsp_fallback = true,
          async = true,
          timeout_ms = 100000,
        }
      end,
    })
  end,
}
