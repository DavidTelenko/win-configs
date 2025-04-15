return {
  'lukas-reineke/indent-blankline.nvim',
  event = 'BufReadPre',
  main = 'ibl',
  ---@module "ibl"
  ---@type ibl.config
  opts = {
    indent = { char = '▏' },
  },
}
