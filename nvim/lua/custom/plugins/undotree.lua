return {
  "mbbill/undotree",
  config = function()
    vim.keymap.set('n', '<leader>h', vim.cmd.UndotreeToggle, {
      desc = 'Toggle [H]istory tree'
    })
  end,
}
