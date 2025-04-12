return {
  'nvim-telescope/telescope.nvim',
  keys = {
    { '<leader>?', desc = 'Recently opened files' },
    { '<leader>sb', desc = 'Existing Buffers' },
    { '<leader>s/', desc = 'In current buffer' },
    { '<leader>sf', desc = 'Files' },
    { '<leader>sh', desc = 'Help' },
    { '<leader>sw', desc = 'Current Word' },
    { '<leader>sg', desc = 'By Grep' },
    { '<leader>sG', desc = 'By Grep With Args' },
    { '<leader>sd', desc = 'Diagnostics' },
    { '<leader>sr', desc = 'Resume' },
    { '<leader>sq', desc = 'Quickfix' },
    { '<leader>s?', desc = 'Keymaps' },
    { '<leader>sc', desc = 'Command history' },
    { '<leader>gf', desc = 'Search Git Files' },
    { '<leader>gc', desc = 'Search Git Commits' },
    { '<leader>gS', desc = 'Search Git Stash' },
    { 'z=', desc = '' },
  },
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
      desc = 'Recently opened files',
    })

    vim.keymap.set('n', '<leader>sb', builtin.buffers, {
      desc = 'Existing Buffers',
    })

    vim.keymap.set('n', '<leader>s/', function()
      builtin.current_buffer_fuzzy_find(
        require('telescope.themes').get_dropdown {
          winblend = 10,
          previewer = false,
        }
      )
    end, { desc = 'In current buffer' })

    vim.keymap.set('n', '<leader>sf', builtin.find_files, {
      desc = 'Files',
    })

    vim.keymap.set('n', '<leader>sh', builtin.help_tags, {
      desc = 'Help',
    })

    vim.keymap.set('n', '<leader>sw', builtin.grep_string, {
      desc = 'Current Word',
    })

    vim.keymap.set('n', '<leader>sg', builtin.live_grep, {
      desc = 'By Grep',
    })

    vim.keymap.set(
      'n',
      '<leader>sG',
      telescope.extensions.live_grep_args.live_grep_args,
      { desc = 'By Grep With Args' }
    )

    vim.keymap.set('n', '<leader>sd', builtin.diagnostics, {
      desc = 'Diagnostics',
    })

    vim.keymap.set('n', '<leader>sr', builtin.resume, {
      desc = 'Resume',
    })

    vim.keymap.set('n', '<leader>sq', builtin.quickfix, {
      desc = 'Quickfix',
    })

    vim.keymap.set('n', '<leader>s?', builtin.keymaps, {
      desc = 'Keymaps',
    })

    vim.keymap.set('n', '<leader>sc', builtin.command_history, {
      desc = 'Command history',
    })

    vim.keymap.set('n', '<leader>gf', builtin.git_files, {
      desc = 'Search Git Files',
    })

    vim.keymap.set('n', '<leader>gc', builtin.git_bcommits, {
      desc = 'Search Git Commits',
    })

    vim.keymap.set('n', '<leader>gS', builtin.git_stash, {
      desc = 'Search Git Stash',
    })

    vim.keymap.set('n', 'z=', builtin.spell_suggest)
  end,
}
