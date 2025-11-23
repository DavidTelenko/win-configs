return {
  {
    'nvim-treesitter/nvim-treesitter',
    event = 'VeryLazy',
    dependencies = {
      'nvim-treesitter/nvim-treesitter-textobjects',
    },
    build = ':TSUpdate',
    config = vim.schedule_wrap(function()
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
              ['aa'] = {
                query = '@parameter.outer',
                desc = 'outer parameter',
              },
              ['ia'] = {
                query = '@parameter.inner',
                desc = 'inner parameter',
              },
              ['af'] = {
                query = '@function.outer',
                desc = 'outer function',
              },
              ['if'] = {
                query = '@function.inner',
                desc = 'inner function',
              },
              ['ac'] = {
                query = '@class.outer',
                desc = 'outer class',
              },
              ['ic'] = {
                query = '@class.inner',
                desc = 'inner class',
              },
              ['a='] = {
                query = '@assignment.outer',
                desc = 'outer assignment',
              },
              ['i='] = {
                query = '@assignment.inner',
                desc = 'inner assignment',
              },
            },
          },
          move = {
            enable = true,
            set_jumps = true, -- whether to set jumps in the jumplist
            goto_next_start = {
              [']a'] = {
                query = '@parameter.outer',
                desc = 'Next parameter',
              },
              [']f'] = {
                query = '@function.outer',
                desc = 'Next start of function',
              },
              [']l'] = {
                query = '@class.outer',
                desc = 'Next start of class',
              },
              [']b'] = {
                query = '@block.outer',
                desc = 'Next start of block',
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
              [']B'] = {
                query = '@block.outer',
                desc = 'Next end of block',
              },
            },
            goto_previous_start = {
              ['[a'] = {
                query = '@parameter.outer',
                desc = 'Previous parameter',
              },
              ['[f'] = {
                query = '@function.outer',
                desc = 'Previous start of function',
              },
              ['[l'] = {
                query = '@class.outer',
                desc = 'Previous start of class',
              },
              ['[b'] = {
                query = '@block.outer',
                desc = 'Previous start of block',
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
              ['[B'] = {
                query = '@block.outer',
                desc = 'Previous end of block',
              },
            },
          },
          swap = {
            enable = true,
            swap_next = {
              ['<leader>cn'] = {
                query = '@parameter.inner',
                desc = 'swap next parameter',
              },
            },
            swap_previous = {
              ['<leader>cp'] = {
                query = '@parameter.inner',
                desc = 'swap previous parameter',
              },
            },
          },
        },
      }
    end),
  },
}
