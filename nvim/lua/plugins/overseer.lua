return {
  'stevearc/overseer.nvim',
  event = { 'VeryLazy' },
  keys = {
    {
      '<leader>co',
      '<cmd>OverseerToggle<cr>',
      mode = 'n',
      desc = 'Overseer toggle',
    },
    {
      '<leader>cr',
      '<cmd>OverseerRun<cr>',
      mode = 'n',
      desc = 'Overseer run',
    },
  },
  opts = {
    templates = { 'builtin' },
  },
}
