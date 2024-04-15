-- Plugin for surrounding text with quotes, brackets, etc.

return {
  "kylechui/nvim-surround",
  version = "*", -- Use for stability; omit to use `main` branch for the latest features
  event = "VeryLazy",
  config = function()
    require("nvim-surround").setup({})
  end
}

-- vim: ts=2 sts=2 sw=2 et
