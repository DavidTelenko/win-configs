-- Git-like branching undotree

return {
  "mbbill/undotree",
  config = function()
    vim.keymap.set('n', '<leader>h', vim.cmd.UndotreeToggle, {
      desc = 'Toggle [H]istory tree'
    })
  end,
}

-- vim: ts=2 sts=2 sw=2 et
