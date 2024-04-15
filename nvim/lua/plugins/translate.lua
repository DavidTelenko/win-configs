return {
  "uga-rosa/translate.nvim",
  config = function()
    vim.keymap.set({ 'x', 'n' }, '<leader>tu', ':Translate UK<cr>', {
      desc = 'Translate to Ukrainian'
    })
    vim.keymap.set({ 'x', 'n' }, '<leader>te', ':Translate EN<cr>', {
      desc = 'Translate to English'
    })
    require('which-key').register(
      { ['<leader>t'] = "[T]ranslate" }, { mode = { 'x', 'n' } }
    )
  end
}
