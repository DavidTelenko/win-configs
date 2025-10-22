return {
  'nvim-pack/nvim-spectre',
  opts = {},
  keys = {
    {
      '<leader>S',
      '<cmd>lua require("spectre").toggle()<CR>',
      desc = 'Replace',
    },
  },
}
