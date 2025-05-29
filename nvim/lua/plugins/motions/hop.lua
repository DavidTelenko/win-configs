return {
  'smoka7/hop.nvim',
  keys = {
    { 's', '<NOP>', mode = { 'n' }, desc = 'Hop' },
    {
      's/',
      '<cmd>HopPattern<cr>',
      mode = { 'n', 'v' },
      desc = 'Hop to pattern',
    },
    {
      'sl',
      '<cmd>HopLine<cr>',
      mode = { 'n', 'v' },
      desc = 'Hop to line',
    },
    {
      'st',
      '<cmd>HopNodes<cr>',
      mode = { 'n', 'v' },
      desc = 'Hop to treesitter nodes',
    },
    { 'f', desc = 'Hop to character', mode = { 'n', 'v' } },
    { 'F', desc = 'Hop back to character', mode = { 'n', 'v' } },
    { 't', desc = 'Hop up to character', mode = { 'n', 'v' } },
    { 'T', desc = 'Hop back up to character', mode = { 'n', 'v' } },
  },
  opts = {},
  config = function(_, opts)
    local hop = require 'hop'
    local directions = require('hop.hint').HintDirection

    hop.setup(opts)

    vim.keymap.set({ 'n', 'v' }, 'f', function()
      hop.hint_char1 {
        direction = directions.AFTER_CURSOR,
        current_line_only = false,
        jump_on_sole_occurrence = false,
      }
    end, { remap = true })

    vim.keymap.set({ 'n', 'v' }, 'F', function()
      hop.hint_char1 {
        direction = directions.BEFORE_CURSOR,
        current_line_only = false,
        jump_on_sole_occurrence = false,
      }
    end, { remap = true })

    vim.keymap.set({ 'n', 'v' }, 't', function()
      hop.hint_char1 {
        direction = directions.AFTER_CURSOR,
        current_line_only = false,
        hint_offset = -1,
        jump_on_sole_occurrence = false,
      }
    end, { remap = true })

    vim.keymap.set({ 'n', 'v' }, 'T', function()
      hop.hint_char1 {
        direction = directions.BEFORE_CURSOR,
        current_line_only = false,
        hint_offset = 1,
        jump_on_sole_occurrence = false,
      }
    end, { remap = true })
  end,
}
