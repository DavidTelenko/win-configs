return {
  'mfussenegger/nvim-lint',
  event = {
    'BufReadPre',
    'BufNewFile',
  },
  config = function()
    local lint = require 'lint'
    local h = require 'helpers.general'
    local js_ts_linters = h.first(h.require_config { 'eslint_d', 'biomejs' })

    lint.linters_by_ft = {
      cpp = { 'cpplint' },
      javascript = js_ts_linters,
      javascriptreact = js_ts_linters,
      python = { 'pylint' },
      svelte = js_ts_linters,
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
