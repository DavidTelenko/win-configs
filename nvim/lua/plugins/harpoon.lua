return {
  'ThePrimeagen/harpoon',
  branch = 'harpoon2',
  lazy = false,
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-telescope/telescope.nvim',
  },
  events = { 'VeryLazy' },
  config = function()
    local harpoon = require 'harpoon'

    harpoon:setup()

    require('which-key').add {
      { '<leader>H', desc = '[H]arpoon' },
    }

    for i = 1, 5 do
      vim.keymap.set('n', '<leader>' .. i, function()
        harpoon:list():select(i)
      end, { desc = 'Navigate to harpoon file [' .. i .. ']' })
    end

    vim.keymap.set('n', '<leader>Ha', function()
      harpoon:list():add()
    end, { desc = '[A]dd file to harpoon' })

    vim.keymap.set('n', '<leader>Hr', function()
      harpoon:list():remove()
    end, { desc = '[R]remove file from harpoon' })

    vim.keymap.set('n', '<leader>Hm', function()
      harpoon.ui:toggle_quick_menu(harpoon:list())
    end, { desc = 'Open quick [M]enu' })

    vim.keymap.set('n', '<leader>p', function()
      harpoon:list():prev()
    end, { desc = '[N]ext harpoon entry' })

    vim.keymap.set('n', '<leader>n', function()
      harpoon:list():next()
    end, { desc = '[P]revious harpoon entry' })
  end,
}
