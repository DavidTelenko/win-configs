return {
  'nvim-treesitter/nvim-treesitter',
  event = 'VeryLazy',
  dependencies = {
    'nvim-treesitter/nvim-treesitter-textobjects',
    -- 'nvim-treesitter/nvim-treesitter-context',
    'nushell/tree-sitter-nu',
  },
  build = ':TSUpdate',
  config = function()
    vim.defer_fn(function()
      require('nvim-treesitter.configs').setup {
        -- Add languages to be installed here that you want installed for treesitter
        -- This seem to completely butcher treesitter parsers installation
        ensure_installed = {
          'bash',
          'c',
          'cpp',
          'css',
          'go',
          'javascript',
          'json',
          'lua',
          'markdown',
          'markdown_inline',
          'nu',
          'python',
          'regex',
          'rust',
          'tsx',
          'typescript',
          'vim',
          'vimdoc',
        },
        sync_install = true,
        ignore_install = {},
        modules = {},
        -- Autoinstall languages that are not installed. Defaults to false (but you can change for yourself!)
        auto_install = false,

        highlight = { enable = true },
        indent = { enable = true },
        incremental_selection = {
          enable = true,
          keymaps = {
            init_selection = '<c-space>',
            node_incremental = '<c-space>',
            scope_incremental = '<c-s>',
            node_decremental = '<M-space>',
          },
        },
        textobjects = {
          select = {
            enable = true,
            lookahead = true, -- Automatically jump forward to textobj, similar to targets.vim
            keymaps = {
              -- You can use the capture groups defined in textobjects.scm
              ['aa'] = { query = '@parameter.outer', desc = 'outer parameter' },
              ['ia'] = { query = '@parameter.inner', desc = 'inner parameter' },
              ['af'] = { query = '@function.outer', desc = 'outer function' },
              ['if'] = { query = '@function.inner', desc = 'inner function' },
              ['ac'] = { query = '@class.outer', desc = 'outer class' },
              ['ic'] = { query = '@class.inner', desc = 'inner class' },
              ['a='] = {
                query = '@assignment.outer',
                desc = 'outer assignment',
              },
              ['i='] = {
                query = '@assignment.inner',
                desc = 'inner assignment',
              },
              ['r='] = { query = '@assignment.rhs', desc = 'rhs assignment' },
              ['l='] = { query = '@assignment.lhs', desc = 'lhs assignment' },
              ['al'] = { query = '@loop.outer', desc = 'outer loop' },
              ['il'] = { query = '@loop.inner', desc = 'inner loop' },
              -- ['ac'] = { query = '@comment.outer', desc = 'outer comment' },
              -- ['ic'] = { query = '@comment.inner', desc = 'inner comment' },
            },
          },
          move = {
            enable = true,
            set_jumps = true, -- whether to set jumps in the jumplist
            goto_next_start = {
              [']f'] = {
                query = '@function.outer',
                desc = 'Next start of function',
              },
              [']l'] = {
                query = '@class.outer',
                desc = 'Next start of class',
              },
            },
            goto_next_end = {
              [']F'] = {
                query = '@function.outer',
                desc = 'Next end of function',
              },
              [']L'] = {
                query = '@class.outer',
                desc = 'Next end of class',
              },
            },
            goto_previous_start = {
              ['[f'] = {
                query = '@function.outer',
                desc = 'Previous start of function',
              },
              ['[l'] = {
                query = '@class.outer',
                desc = 'Previous start of class',
              },
            },
            goto_previous_end = {
              ['[F'] = {
                query = '@function.outer',
                desc = 'Previous end of function',
              },
              ['[L'] = {
                query = '@class.outer',
                desc = 'Previous end of class',
              },
            },
          },
          swap = {
            enable = true,
            swap_next = {
              ['<leader>sa'] = {
                query = '@parameter.inner',
                desc = 'swap next parameter',
              },
            },
            swap_previous = {
              ['<leader>sA'] = {
                query = '@parameter.inner',
                desc = 'swap previous parameter',
              },
            },
          },
        },
      }
    end, 0)
  end,
}
