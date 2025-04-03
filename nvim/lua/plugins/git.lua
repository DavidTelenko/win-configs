return {
  {
    'tpope/vim-fugitive',
    cmd = 'Git',
    keys = {
      {
        '<leader>gg',
        '<cmd>Git<cr>',
        desc = 'Git menu (fugitive)',
      },
    },
  },
  {
    'tpope/vim-rhubarb',
    cmd = 'GBrowse',
  },
  {
    'sindrets/diffview.nvim',
    lazy = false,
  },
  {
    'lewis6991/gitsigns.nvim',
    event = 'BufReadPre',
    keys = {},
    opts = {
      -- See `:help gitsigns.txt`
      signs = {
        add = { text = '+' },
        change = { text = '~' },
        delete = { text = '_' },
        topdelete = { text = '‾' },
        changedelete = { text = '~' },
      },
      signs_staged = {
        add = { text = '' },
        change = { text = '' },
        delete = { text = '' },
        topdelete = { text = '' },
        changedelete = { text = '' },
        untracked = { text = '' },
      },
      on_attach = function(bufnr)
        vim.keymap.set('n', '<leader>gp', require('gitsigns').preview_hunk, {
          buffer = bufnr,
          desc = 'Preview git hunk',
        })

        -- don't override the built-in and fugitive keymaps
        local gs = package.loaded.gitsigns

        vim.keymap.set({ 'n', 'v' }, ']c', function()
          if vim.wo.diff then
            return ']c'
          end
          vim.schedule(function()
            gs.next_hunk()
          end)
          return '<Ignore>'
        end, {
          expr = true,
          buffer = bufnr,
          desc = 'Next git hunk',
        })

        vim.keymap.set({ 'n', 'v' }, '[c', function()
          if vim.wo.diff then
            return '[c'
          end
          vim.schedule(function()
            gs.prev_hunk()
          end)
          return '<Ignore>'
        end, {
          expr = true,
          buffer = bufnr,
          desc = 'Previous git hunk',
        })

        vim.keymap.set('n', '<leader>gs', gs.stage_hunk, {
          desc = 'Stage hunk',
        })

        vim.keymap.set('n', '<leader>gr', gs.reset_hunk, {
          desc = 'Reset hunk',
        })

        vim.keymap.set('v', '<leader>gs', function()
          gs.stage_hunk { vim.fn.line '.', vim.fn.line 'v' }
        end, { desc = 'Stage hunk' })

        vim.keymap.set('v', '<leader>gr', function()
          gs.reset_hunk { vim.fn.line '.', vim.fn.line 'v' }
        end, { desc = 'Reset hunk' })

        vim.keymap.set('n', '<leader>gb', gs.toggle_current_line_blame, {
          desc = 'Toggle git Blame',
        })

        vim.keymap.set('n', '<leader>gB', gs.blame, {
          desc = 'Toggle Blame window',
        })
      end,
    },
  },
}
