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

    local wk = require 'which-key'

    wk.add {
      { '<leader>H', desc = '[H]arpoon' },
    }

    for i = 1, 9 do
      vim.keymap.set('n', '<leader>' .. i, function()
        harpoon:list():select(i)
      end, { desc = 'Navigate to harpoon file [' .. i .. ']' })
      wk.add { '<leader>' .. i, hidden = true }
    end

    wk.add { '<leader>1', desc = 'Navigate to harpoon file [1..9]' }

    vim.keymap.set('n', '<leader>ha', function()
      harpoon:list():add()
    end, { desc = '[A]dd file to harpoon' })

    vim.keymap.set('n', '<leader>hr', function()
      harpoon:list():remove()
    end, { desc = '[R]remove file from harpoon' })

    vim.keymap.set('n', '<leader>hm', function()
      harpoon.ui:toggle_quick_menu(harpoon:list())
    end, { desc = 'Open quick [M]enu' })

    -- basic telescope configuration
    local conf = require('telescope.config').values

    local function toggle_telescope(harpoon_files)
      local file_paths = {}
      for _, item in ipairs(harpoon_files.items) do
        table.insert(file_paths, item.value)
      end

      require('telescope.pickers')
        .new({}, {
          prompt_title = 'Harpoon',
          finder = require('telescope.finders').new_table {
            results = file_paths,
          },
          previewer = conf.file_previewer {},
          sorter = conf.generic_sorter {},
        })
        :find()
    end

    vim.keymap.set('n', '<leader><space>', function()
      toggle_telescope(harpoon:list())
    end, { desc = 'Open harpoon window' })
  end,
}
