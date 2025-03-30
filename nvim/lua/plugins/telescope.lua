return {
  'nvim-telescope/telescope.nvim',
  lazy = false,
  dependencies = {
    'nvim-lua/plenary.nvim',
    -- Fuzzy Finder Algorithm which requires local dependencies to be built.
    -- Only load if `make` is available. Make sure you have the system
    -- requirements installed.
    {
      'nvim-telescope/telescope-fzf-native.nvim',
      build = 'make',
      cond = function()
        return vim.fn.executable 'make' == 1
      end,
    },
    'nvim-telescope/telescope-ui-select.nvim',
    'nvim-telescope/telescope-live-grep-args.nvim',
  },
  config = function()
    local telescope = require 'telescope'
    local lga_actions = require 'telescope-live-grep-args.actions'

    telescope.setup {
      defaults = {
        wrap_results = true,
        layout_config = {
          horizontal = {
            height = 0.95,
            preview_cutoff = 100,
            prompt_position = 'bottom',
            width = 0.9,
          },
        },
      },
      extensions = {
        fzf = {
          fuzzy = true,
          override_generic_sorter = true,
          override_file_sorter = true,
          case_mode = 'smart_case',
        },
        live_grep_args = {
          auto_quoting = true,
          mappings = {
            i = {
              ['<C-k>'] = lga_actions.quote_prompt(),
              ['<C-i>'] = lga_actions.quote_prompt { postfix = '--iglob' },
              ['<C-space>'] = lga_actions.to_fuzzy_refine,
            },
          },
        },
      },
    }

    -- Enable telescope fzf native, if installed
    pcall(telescope.load_extension, 'fzf')
    pcall(telescope.load_extension, 'live_grep_args')
    pcall(telescope.load_extension, 'ui-select')

    -- See `:help telescope.builtin`
    local builtin = require 'telescope.builtin'

    vim.keymap.set('n', '<leader>?', builtin.oldfiles, {
      desc = 'Search recently opened files',
    })

    vim.keymap.set('n', '<leader>sb', builtin.buffers, {
      desc = 'Existing [B]uffers',
    })

    vim.keymap.set('n', '<leader>s/', function()
      builtin.current_buffer_fuzzy_find(
        require('telescope.themes').get_dropdown {
          winblend = 10,
          previewer = false,
        }
      )
    end, { desc = 'In current buffer' })

    vim.keymap.set('n', '<leader>gf', builtin.git_files, {
      desc = '[G]it [F]iles',
    })

    vim.keymap.set('n', '<leader>sf', builtin.find_files, {
      desc = '[F]iles',
    })

    vim.keymap.set('n', '<leader>sh', builtin.help_tags, {
      desc = '[H]elp',
    })

    vim.keymap.set('n', '<leader>sw', builtin.grep_string, {
      desc = 'Current [W]ord',
    })

    vim.keymap.set('n', '<leader>sg', builtin.live_grep, {
      desc = 'By [G]rep',
    })

    vim.keymap.set('n', '<leader>sd', builtin.diagnostics, {
      desc = '[D]iagnostics',
    })

    vim.keymap.set('n', '<leader>sr', builtin.resume, {
      desc = '[R]esume',
    })

    vim.keymap.set('n', '<leader>sq', builtin.quickfix, {
      desc = '[Q]uickfix',
    })

    vim.keymap.set('n', '<leader>s?', builtin.keymaps, {
      desc = '[K]eymaps',
    })
  end,
}
