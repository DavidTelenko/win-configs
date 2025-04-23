return {
  'mfussenegger/nvim-lint',
  event = { 'BufWritePost', 'DirChanged' },
  config = function()
    local lint = require 'lint'
    local h = require 'helpers.general'

    function setup()
      local js_ts_linters = h.first(h.require_config { 'eslint_d', 'biomejs' })
      local configs = require 'helpers.configs'

      for _, name in ipairs(js_ts_linters) do
        lint.linters[name].cwd = vim.fs.root(vim.fn.getcwd(), configs[name])
      end

      lint.linters_by_ft = {
        cpp = { 'cpplint' },
        javascript = js_ts_linters,
        javascriptreact = js_ts_linters,
        python = { 'pylint' },
        svelte = js_ts_linters,
        typescript = js_ts_linters,
        typescriptreact = js_ts_linters,
      }
    end
    setup()

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

    vim.api.nvim_create_autocmd('DirChanged', {
      group = vim.api.nvim_create_augroup('LintDirChanged', {
        clear = true,
      }),
      callback = setup,
    })

    --- TODO: find a better way to offload some sections in lualine
    local lualine = require 'lualine'
    local sections = lualine.get_config().sections

    table.insert(sections.lualine_x, function()
      local linters = lint.get_running(0)
      if #linters == 0 then
        return '󰕥'
      end
      return table.concat(linters, ', ') .. ' 󰶚'
    end)

    require('lualine').setup {
      sections = sections,
    }
  end,
}
