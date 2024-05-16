return {
  {
    -- Automatically add closing pairs
    'windwp/nvim-autopairs',
    event = 'InsertEnter',
    -- Optional dependency
    dependencies = { 'hrsh7th/nvim-cmp' },
    config = function()
      require('nvim-autopairs').setup {}
      -- If you want to automatically add `(` after selecting a function or method
      local cmp_autopairs = require 'nvim-autopairs.completion.cmp'
      local cmp = require 'cmp'
      cmp.event:on('confirm_done', cmp_autopairs.on_confirm_done())
    end,
  },
  {
    -- Autocompletion
    'hrsh7th/nvim-cmp',
    event = 'InsertEnter',
    dependencies = {
      -- Snippet Engine & its associated nvim-cmp source
      'L3MON4D3/LuaSnip',
      'saadparwaiz1/cmp_luasnip',

      -- Adds LSP completion capabilities
      'hrsh7th/cmp-nvim-lsp',

      -- Adds a number of user-friendly snippets
      'rafamadriz/friendly-snippets',
      -- Completion icons
      'onsails/lspkind.nvim'
    },
    config = function()
      local cmp = require 'cmp'
      local luasnip = require 'luasnip'
      local lspkind = require 'lspkind'

      require('luasnip.loaders.from_vscode').lazy_load()

      luasnip.config.setup {}
      lspkind.init {}

      local function jump_if_jumpable(i)
        return function(fallback)
          if luasnip.locally_jumpable(i) then
            luasnip.jump(i)
          else
            fallback()
          end
        end
      end

      cmp.setup {
        sources = {
          { name = 'nvim_lsp' },
          { name = 'luasnip' },
          { name = 'path' },
        },
        formatting = {
          format = lspkind.cmp_format({
            mode = 'symbol_text',
            maxwidth = 50,
            ellipsis_char = '...',
            show_labelDetails = true,
            before = function(entry, vim_item)
              return vim_item
            end
          })
        },
        snippet = {
          expand = function(args)
            luasnip.lsp_expand(args.body)
          end,
        },
        completion = {
          completeopt = 'menu,menuone,noinsert',
        },
        mapping = cmp.mapping.preset.insert {
          ['<CR>'] = cmp.mapping.abort(),
          ['<C-n>'] = cmp.mapping.select_next_item(),
          ['<C-p>'] = cmp.mapping.select_prev_item(),
          ['<C-d>'] = cmp.mapping.scroll_docs(-4),
          ['<C-f>'] = cmp.mapping.scroll_docs(4),
          ['<Tab>'] = cmp.mapping.confirm {
            behavior = cmp.ConfirmBehavior.Replace,
            select = true,
          },
          -- The following binding relies on system wide mappings A-h, A-j, A-k, A-l, for arrow keys
          ['<left>'] = cmp.mapping(jump_if_jumpable(-1), { 'i', 's' }),
          ['<right>'] = cmp.mapping(jump_if_jumpable(1), { 'i', 's' }),
          ['<up>'] = cmp.mapping.select_prev_item(),
          ['<down>'] = cmp.mapping.select_next_item(),
        },
      }
    end,
  }
}
