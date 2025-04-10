return {
  'stevearc/conform.nvim',
  event = {
    'BufWritePost',
  },
  opts = function()
    local h = require 'helpers.general'

    local js_ts_formatters = h.first {
      h.require_config { 'prettierd', 'eslint_d' }, -- order here is important
      h.require_config 'deno_fmt',
      'biome', -- fallback (important to configure in mason-tool-installer)
    }

    local json_formatters = h.first {
      h.require_config 'prettierd',
      'biome',
    }

    return {
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
        json = json_formatters,
        jsonc = json_formatters,
        lua = { 'stylua' },
        markdown = { 'prettierd' },
        mdx = { 'prettierd' },
        python = { 'black' },
        svelte = h.first { h.require_config 'prettierd', 'biome' },
        typescript = js_ts_formatters,
        typescriptreact = js_ts_formatters,
        yaml = { 'prettierd' },
      },
    }
  end,
}
