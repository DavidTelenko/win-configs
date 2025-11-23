return {
  'smoka7/hop.nvim',
  keys = {
    { 's', '<NOP>', mode = { 'n' }, desc = 'Hop' },
    { 's/', desc = 'Hop to pattern' },
    { 'sd', desc = 'Hop to word' },
    { 'sl', desc = 'Hop to line' },
    { 'st', desc = 'Hop to treesitter nodes' },
    { 'sf', desc = 'Hop to character' },
  },
  opts = {},
  config = function(_, opts)
    local hop = require 'hop'
    local hop_ts = require 'hop-treesitter'

    hop.setup(opts)

    vim.keymap.set({ 'n', 'v' }, 'sf', function()
      hop.hint_char1 {
        current_line_only = false,
        jump_on_sole_occurrence = false,
      }
    end, { remap = true })

    vim.keymap.set({ 'n', 'v' }, 'sl', function()
      hop.hint_lines {}
    end, { remap = true, desc = 'Hop to line' })

    vim.keymap.set({ 'n', 'v' }, 'sd', function()
      hop.hint_words {}
    end, { remap = true, desc = 'Hop to word' })

    vim.keymap.set({ 'n', 'v' }, 'st', function()
      hop_ts.hint_nodes {}
    end, { remap = true, desc = 'Hop to treesitter nodes' })

    vim.keymap.set({ 'n', 'v' }, 's/', function()
      hop.hint_patterns {}
    end, { remap = true, desc = 'Hop to pattern' })
  end,
}
