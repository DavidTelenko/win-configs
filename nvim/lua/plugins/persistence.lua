return {
  "folke/persistence.nvim",
  lazy = false,
  config = function()
    require("persistence").setup({})

    vim.keymap.set("n", "<leader>ps", require("persistence").load,
      { desc = "Restore the session for the cwd" })

    vim.keymap.set("n", "<leader>pl",
      function() require("persistence").load({ last = true }) end,
      { desc = "Restore the last session" })

    vim.keymap.set("n", "<leader>pd", require("persistence").stop,
      { desc = "Stop Persistence" })

    require('which-key').register({
      ['<leader>p'] = '[P]ersistence',
    })
  end
}
