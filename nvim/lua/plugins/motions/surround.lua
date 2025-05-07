return {
  'kylechui/nvim-surround',
  keys = {
    { 'S', '<NOP>', mode = { 'n', 'v' } },
    { 'ds' },
    { 'cs' },
    { 'ys' },
    { 's', mode = 'v' },
  },
  opts = {
    keymaps = {
      visual = 's',
    },
  },
  config = function(_, opts)
    local surround = require 'nvim-surround'
    local surr_utils = require 'nvim-surround.config'
    local ts_utils = require 'nvim-treesitter.ts_utils'

    surround.setup(opts)

    surround.buffer_setup {
      surrounds = {
        m = {
          add = function()
            local result =
              surr_utils.get_input 'Enter the markdown codeblock language: '
            if result then
              return { { '```' .. result }, { '```' } }
            end
          end,
        },
        g = {
          add = function()
            local result = surr_utils.get_input 'Enter the generic name: '
            if result then
              return { { result .. '<' }, { '>' } }
            end
          end,
          find = function()
            return surr_utils.get_selection { node = 'generic_type' }
          end,
          delete = '^(.-<)().-(>)()$',
          change = {
            target = '^(.-<)().-(>)()$',
            replacement = function()
              local result = surr_utils.get_input 'Enter the generic name: '
              if result then
                return { { result .. '<' }, { '>' } }
              end
            end,
          },
        },
        s = {
          add = function()
            local cur = ts_utils.get_node_at_cursor(0, true)
            local language = vim.bo.filetype
            local is_js_ts = (
              language == 'javascript'
              or language == 'javascriptreact'
              or language == 'typescript'
              or language == 'typescriptreact'
            )

            if is_js_ts and cur ~= nil then
              local cur_type = cur:type()
              local interpolation_surround = { { '${' }, { '}' } }
              if
                cur and (cur_type == 'string' or cur_type == 'string_fragment')
              then
                vim.cmd.normal 'csq`'
                return interpolation_surround
              elseif cur and cur_type == 'template_string' then
                return interpolation_surround
              else
                return { { '`${' }, { '}`' } }
              end
            end
          end,
        },
        l = {
          add = function()
            local input = surr_utils.get_input 'Link name: '
            if input then
              return {
                { '[' .. input .. '](' },
                { ')' },
              }
            end
          end,
          find = '%b[]%b()',
          delete = '^(%[)().-(%]%b())()$',
        },
      },
    }
  end,
}
