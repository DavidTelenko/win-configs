return {
  'folke/snacks.nvim',
  ---@type snacks.Config
  opts = {
    gitbrowse = { enabled = true },
  },
  keys = {
    {
      '<leader>go',
      function()
        Snacks.gitbrowse.open()
      end,
      mode = 'n',
      desc = '[O]pen repository',
    },
  },
}
