return {
  'nvim-treesitter/nvim-treesitter',
  event = 'VeryLazy',
  dependencies = {
    'nvim-treesitter/nvim-treesitter-textobjects',
    'nvim-treesitter/nvim-treesitter-context',
    'nushell/tree-sitter-nu',
  },
  build = ':TSUpdate',
  config = function()
    vim.defer_fn(function()
      require('nvim-treesitter.configs').setup {
        -- Add languages to be installed here that you want installed for treesitter
        -- This seem to completely butcher treesitter parsers installation
        ensure_installed = {
          'c',
          'cpp',
          'go',
          'lua',
          'python',
          'rust',
          'vimdoc',
          'vim',
          'bash',
          'nu',
          'regex',
          'markdown',
          'markdown_inline',
          'typescript',
          'javascript',
          'json',
          'tsx',
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
            },
          },
          move = {
            enable = true,
            set_jumps = true, -- whether to set jumps in the jumplist
            goto_next_start = {
              [']m'] = {
                query = '@function.outer',
                desc = 'Next start of function',
              },
              [']]'] = {
                query = '@class.outer',
                desc = 'Next start of class',
              },
            },
            goto_next_end = {
              [']M'] = {
                query = '@function.outer',
                desc = 'Next end of function',
              },
              [']['] = {
                query = '@class.outer',
                desc = 'Next end of class',
              },
            },
            goto_previous_start = {
              ['[m'] = {
                query = '@function.outer',
                desc = 'Previous start of function',
              },
              ['[['] = {
                query = '@class.outer',
                desc = 'Previous start of class',
              },
            },
            goto_previous_end = {
              ['[M'] = {
                query = '@function.outer',
                desc = 'Previous end of function',
              },
              ['[]'] = {
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

      require('treesitter-context').setup {
        enable = false,           -- Enable this plugin (Can be enabled/disabled later via commands)
        max_lines = 1,            -- How many lines the window should span. Values <= 0 mean no limit.
        min_window_height = 0,    -- Minimum editor window height to enable context. Values <= 0 mean no limit.
        line_numbers = true,
        multiline_threshold = 20, -- Maximum number of lines to show for a single context
        trim_scope = 'outer',     -- Which context lines to discard if `max_lines` is exceeded. Choices: 'inner', 'outer'
        mode = 'cursor',          -- Line used to calculate context. Choices: 'cursor', 'topline'
        -- Separator between context and content. Should be a single character string, like '-'.
        -- When separator is set, the context will only show up when there are at least 2 lines above cursorline.
        separator = nil,
        zindex = 20,     -- The Z-index of the context window
        on_attach = nil, -- (fun(buf: integer): boolean) return false to disable attaching
      }

      vim.keymap.set('n', '[x', function()
        require('treesitter-context').go_to_context(vim.v.count1)
      end, { silent = true, desc = 'Jump to previous context' })
    end, 0)
  end,
}
