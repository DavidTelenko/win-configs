-- [[ Setting options ]]

-- Leader mappings
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Set highlight on search
vim.o.hlsearch = false

-- Make line numbers default
vim.wo.number = true
vim.wo.relativenumber = true

-- Enable mouse mode
vim.o.mouse = 'a'

-- Sync clipboard between OS and Neovim.
--  Remove this option if you want your OS clipboard to remain independent.
--  See `:help 'clipboard'`
vim.o.clipboard = 'unnamedplus'

vim.o.colorcolumn = '80'
vim.o.scrolloff = 8

-- Enable break indent
vim.o.breakindent = true

-- Save undo history
vim.o.swapfile = false
vim.o.backup = false
vim.o.undofile = true

-- Case-insensitive searching UNLESS \C or capital in search
vim.o.ignorecase = true
vim.o.smartcase = true
vim.o.smartindent = true

-- Keep signcolumn on by default
vim.wo.signcolumn = 'yes'

-- Decrease update time
vim.o.updatetime = 250
vim.o.timeoutlen = 300

-- Set completeopt to have a better completion experience
vim.o.completeopt = 'menuone,noselect'

-- NOTE: You should make sure your terminal supports this
vim.o.termguicolors = true
-- vim.o.shell = 'nu'

vim.o.list = true
-- vim.o.listchars = "tab:> ,trail:🞄,nbsp:+,space:🞄"
vim.o.listchars = 'tab:· ,trail:·,nbsp:+,space:·'

vim.o.tabstop = 4
vim.o.softtabstop = 4
vim.o.shiftwidth = 4
vim.o.expandtab = true
vim.o.smarttab = true

vim.o.spell = true
vim.o.spelllang = 'en'

vim.o.wrap = false

vim.g.netrw_banner = 0
vim.g.netrw_hide = 0
vim.g.netrw_bufsettings = 'noma nomod rnu nowrap ro nobl'

local function escape(str)
  local escape_chars = [[;,."|\]]
  return vim.fn.escape(str, escape_chars)
end

local en_n = [[`qwertyuiop[]asdfghjkl;'zxcvbnm]]
local ua_n = [['йцукенгшщзхїфівапролджєячсмить]]
local en_s = [[~QWERTYUIOP{}ASDFGHJKL:"ZXCVBNM<>]]
local ua_s = [[₴ЙЦУКЕНГШЩЗХЇФІВАПРОЛДЖЄЯЧСМИТЬБЮ]]

vim.o.langmap = vim.fn.join({
  --  to           ;        from
  escape(ua_n)
    .. ';'
    .. escape(en_n),
  escape(ua_s) .. ';' .. escape(en_s),
}, ',')

vim.o.langremap = false

-- [[ Highlight on yank ]]
-- See `:help vim.highlight.on_yank()`
local highlight_group = vim.api.nvim_create_augroup('YankHighlight', {
  clear = true,
})
local netrw_group = vim.api.nvim_create_augroup('Netrw', {
  clear = true,
})

vim.api.nvim_create_autocmd('TextYankPost', {
  callback = function()
    vim.highlight.on_yank()
  end,
  group = highlight_group,
  pattern = '*',
})

-- netrw keymaps for more 'lettered' experience
vim.api.nvim_create_autocmd('BufModifiedSet', {
  group = netrw_group,
  pattern = '*',
  callback = function()
    if not (vim.bo and vim.bo.filetype == 'netrw') then
      return
    end
    vim.keymap.set('n', 'l', '<cr>', { buffer = true, remap = true })
    vim.keymap.set('n', 'h', '-', { buffer = true, remap = true })
    vim.keymap.set('n', 'a', '%', { buffer = true, remap = true })
  end,
})

-- disable some options in terminal mode
vim.api.nvim_create_autocmd('TermOpen', {
  group = vim.api.nvim_create_augroup('TerminalMode', { clear = true }),
  pattern = '*',
  callback = function()
    vim.o.spell = false
    vim.wo.signcolumn = 'yes'
  end,
})

-- Returning Explore command in nvim 0.10
vim.api.nvim_create_user_command('E', function()
  vim.cmd 'Explore'
end, {})

-- vim: ts=2 sts=2 sw=2 et
