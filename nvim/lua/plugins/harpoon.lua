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

    harpoon:setup {
      settings = {
        save_on_toggle = true,
      },
    }

    local harpoon_extensions = require 'harpoon.extensions'
    harpoon:extend(harpoon_extensions.builtins.highlight_current_file())

    local wk = require 'which-key'

    for i = 1, 9 do
      vim.keymap.set('n', '<leader>' .. i, function()
        harpoon:list():select(i)
      end, { desc = 'Navigate to harpoon file [' .. i .. ']' })
      wk.add { '<leader>' .. i, hidden = true }
    end

    wk.add { '<leader>1', desc = 'Navigate to harpoon file [1..9]' }

    vim.keymap.set('n', '<leader>ha', function()
      harpoon:list():add()
    end, { desc = 'Add file to harpoon' })

    vim.keymap.set('n', '<leader>hr', function()
      harpoon:list():remove()
    end, { desc = 'Rremove file from harpoon' })

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
      -- toggle_telescope(harpoon:list())
      harpoon.ui:toggle_quick_menu(harpoon:list(), {
        border = 'rounded',
        title_pos = 'center',
        height_in_lines = 20,
        ui_width_ratio = 0.9,
        title = ' Harpoon ',
      })
    end, { desc = 'Open harpoon window' })

    vim.keymap.set('n', '<leader>hs', function()
      toggle_telescope(harpoon:list())
    end, { desc = 'Search' })
  end,
}
