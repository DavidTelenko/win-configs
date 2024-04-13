return {
  "zbirenbaum/copilot.lua",
  config = function()
    vim.defer_fn(function()
      require('copilot').setup {
        panel = {
          enabled = true,
          auto_refresh = false,
          keymap = {
            jump_prev = "[[",
            jump_next = "]]",
            accept = "<CR>",
            refresh = "gr",
            open = "<M-CR>"
          },
          layout = {
            position = "bottom", -- | top | left | right
            ratio = 0.4
          },
        },
        suggestion = {
          enabled = true,
          auto_trigger = false,
          debounce = 75,
          keymap = {
            accept = "<A-;>",
            accept_word = false,
            accept_line = false,
            next = "<A-]>",
            prev = "<A-[>",
            dismiss = "<C-L>",
          },
        },
        filetypes = {
          yaml = false,
          markdown = false,
          help = false,
          gitcommit = false,
          gitrebase = false,
          hgcommit = false,
          svn = false,
          cvs = false,
          ["."] = false,
        },
        copilot_node_command = 'node', -- Node.js version must be > 18.x
        server_opts_overrides = {},
      }
      local copilot_suggestion_enabled = false
      vim.keymap.set('n', '<leader>ct',
        function()
          require('copilot.suggestion').toggle_auto_trigger()
          copilot_suggestion_enabled = not copilot_suggestion_enabled
          print('Copilot suggestion auto trigger: [' .. (copilot_suggestion_enabled and 'enabled' or 'disabled') .. ']')
        end,
        { desc = '[C]opilot [T]tirgger auto suggestion' })
    end, 0)
  end
}
