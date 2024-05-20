return {
  'akinsho/flutter-tools.nvim',
  lazy = false,
  dependencies = {
    'nvim-lua/plenary.nvim',
    'stevearc/dressing.nvim',
  },
  config = function()
    require('flutter-tools').setup {}
    require('telescope').load_extension 'flutter'

    local flutter_group = vim.api.nvim_create_augroup('FlutterTools', {
      clear = true,
    })

    vim.api.nvim_create_autocmd('BufEnter', {
      pattern = { '*.dart' },
      callback = function()
        vim.keymap.set('n', '<leader>fr', '<cmd>FlutterRun<cr>', { desc = '[F]lutter [R]un' })
        vim.keymap.set('n', '<leader>ft', function()
          require('telescope').extensions.flutter.commands()
        end, { desc = '[F]lutter [T]ools' })
      end,
      group = flutter_group,
    })
  end,
}
