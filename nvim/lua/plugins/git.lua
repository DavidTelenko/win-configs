return {
  {
    'tpope/vim-fugitive',
    cmd = 'Git',
    keys = {
      { '<leader>gg', '<cmd>Git<cr>', { desc = '[G]it menu (fugitive)' } },
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
    keys = {
      {
        '<leader>gb',
        '<cmd>Gitsigns toggle_current_line_blame<cr>',
        desc = 'Toggle git [B]lame',
      },
      {
        '<leader>gB',
        '<cmd>Gitsigns blame<cr>',
        desc = 'Toggle git [B]lame window',
      },
    },
    opts = {
      -- See `:help gitsigns.txt`
      signs = {
        add = { text = '+' },
        change = { text = '~' },
        delete = { text = '_' },
        topdelete = { text = '‾' },
        changedelete = { text = '~' },
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
      end,
    },
  },
}
