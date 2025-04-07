return {
  'smoka7/hop.nvim',
  keys = {
    { 's', '<NOP>', mode = { 'n', 'v' }, desc = 'Hop' },
    {
      'sa',
      '<cmd>HopAnywhere<cr>',
      mode = { 'n', 'v' },
      desc = 'Hop anywhere',
    },
    {
      'ss',
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
    {
      'f',
      desc = 'Hop to character',
    },
    {
      'F',
      desc = 'Hop back to character',
    },
    {
      't',
      desc = 'Hop up to character',
    },
    {
      'T',
      desc = 'Hop back up to character',
    },
  },
  version = '*',
  config = function()
    local hop = require 'hop'
    local directions = require('hop.hint').HintDirection

    hop.setup {
      keys = 'asdfghjkl;',
    }

    vim.keymap.set('', 'f', function()
      hop.hint_char1 {
        direction = directions.AFTER_CURSOR,
        current_line_only = true,
      }
    end, { remap = true })

    vim.keymap.set('', 'F', function()
      hop.hint_char1 {
        direction = directions.BEFORE_CURSOR,
        current_line_only = true,
      }
    end, { remap = true })

    vim.keymap.set('', 't', function()
      hop.hint_char1 {
        direction = directions.AFTER_CURSOR,
        current_line_only = true,
        hint_offset = -1,
      }
    end, { remap = true })

    vim.keymap.set('', 'T', function()
      hop.hint_char1 {
        direction = directions.BEFORE_CURSOR,
        current_line_only = true,
        hint_offset = 1,
      }
    end, { remap = true })
  end,
}
