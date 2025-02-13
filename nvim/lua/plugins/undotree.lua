return {
  'mbbill/undotree',
  keys = {
    { '<leader>h' },
  },
  config = function()
    vim.keymap.set('n', '<leader>hh', vim.cmd.UndotreeToggle, {
      desc = 'Toggle [H]istory tree',
    })
  end,
}
