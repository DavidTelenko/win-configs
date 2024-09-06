return {
  'stevearc/conform.nvim',
  event = { 'BufReadPre', 'BufNewFile' },
  opts = {
    formatters_by_ft = {
      javascript = { 'biome' },
      typescript = { 'biome' },
      javascriptreact = { 'biome' },
      typescriptreact = { 'biome' },
      svelte = { 'prettier' },
      css = { 'prettier' },
      html = { 'prettier' },
      json = { 'biome' },
      yaml = { 'prettier' },
      markdown = { 'prettier' },
      graphql = { 'prettier' },
      lua = { 'stylua' },
      python = { 'black' },
    },
    format_on_save = {
      lsp_fallback = true,
      async = false,
      timeout_ms = 100000,
    },
  },
}
