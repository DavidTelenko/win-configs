return {
  -- Automatically add closing pairs
  'windwp/nvim-autopairs',
  event = { 'InsertEnter', 'CmdlineEnter' },
  -- Optional dependency
  config = function()
    require('nvim-autopairs').setup {}
    -- If you want to automatically add `(` after selecting a function or method
    local cmp_autopairs = require 'nvim-autopairs.completion.cmp'
    local cmp = require 'cmp'
    cmp.event:on('confirm_done', cmp_autopairs.on_confirm_done())
  end,
}
