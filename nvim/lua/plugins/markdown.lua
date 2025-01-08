return {
  {
    'iamcco/markdown-preview.nvim',
    cmd = { 'MarkdownPreviewToggle', 'MarkdownPreview', 'MarkdownPreviewStop' },
    ft = { 'markdown' },
    build = function()
      vim.fn['mkdp#util#install']()
    end,
  },
  {
    'davidmh/mdx.nvim',
    config = true,
    event = { 'BufEnter *.mdx' },
    dependencies = { 'nvim-treesitter/nvim-treesitter' },
  },
}
