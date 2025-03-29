-- Leader mappings
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Set highlight on search
vim.o.hlsearch = false

-- Make line numbers default
vim.wo.number = true
vim.wo.relativenumber = true

-- Disable mouse mode
vim.o.mouse = ''

-- Sync clipboard between OS and Neovim.
--  Remove this option if you want your OS clipboard to remain independent.
--  See `:help 'clipboard'`
vim.o.clipboard = 'unnamedplus'

-- This thing ---------------------------------------------------------------->
vim.o.colorcolumn = '80'

-- Scroll will trigger leaving 8 lines at the bottom
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

-- Font
vim.o.guifont = 'RobotoMono Nerd Font Mono:h18'

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

-- This little circles to see spaces (VS Code habit)
vim.o.list = true
-- vim.o.listchars = "tab:> ,trail:🞄,nbsp:+,space:🞄"
vim.o.listchars = 'tab:· ,trail:·,nbsp:+,space:·'

-- Tabs
vim.o.tabstop = 4
vim.o.softtabstop = 4
vim.o.shiftwidth = 4
vim.o.expandtab = true
vim.o.smarttab = true

-- Spellcheck
vim.o.spell = true
vim.o.spelllang = 'en'

-- Wrapping
vim.o.wrap = true
vim.o.linebreak = true
vim.o.smoothscroll = true

-- Folding
vim.o.foldmethod = 'indent'
vim.o.foldlevel = 99

-- Netrw
vim.g.netrw_banner = 0
vim.g.netrw_hide = 0
vim.g.netrw_bufsettings = 'noma nomod rnu nowrap ro nobl'

-- Attempt to make it work in ua_uk locale
local function escape(str)
  local escape_chars = [[;,."|\]]
  return vim.fn.escape(str, escape_chars)
end

local en_n = [[qwertyuiop[]asdfghjkl;'zxcvbnm]]
local ua_n = [[йцукенгшщзхїфівапролджєячсмить]]
local en_s = [[QWERTYUIOP{}ASDFGHJKL:"ZXCVBNM<>]]
local ua_s =
  [[ЙЦУКЕНГШЩЗХЇФІВАПРОЛДЖЄЯЧСМИТЬБЮ]]

vim.o.langmap = vim.fn.join({
  escape(ua_n) .. ';' .. escape(en_n),
  escape(ua_s) .. ';' .. escape(en_s),
}, ',')

vim.o.langremap = false

-- [[ Highlight on yank ]]
-- See `:help vim.highlight.on_yank()`
vim.api.nvim_create_autocmd('TextYankPost', {
  callback = function()
    vim.highlight.on_yank()
  end,
  group = vim.api.nvim_create_augroup('YankHighlight', {
    clear = true,
  }),
  pattern = '*',
})

-- netrw keymaps for more 'lettered' experience
vim.api.nvim_create_autocmd('BufModifiedSet', {
  group = vim.api.nvim_create_augroup('Netrw', {
    clear = true,
  }),
  pattern = '*',
  callback = function()
    if not (vim.bo and vim.bo.filetype == 'netrw') then
      return
    end
    vim.keymap.set('n', 'l', '<cr>', { buffer = true, remap = true })
    vim.keymap.set('n', 'h', '-', { buffer = true, remap = true })
    vim.keymap.set('n', 'a', '%', { buffer = true, remap = true })
    vim.keymap.set('n', '<F1>', '<Esc>', { buffer = true, remap = true })
  end,
})

-- Clear redundant spaces at the end of lines
vim.api.nvim_create_autocmd({ 'BufWritePre' }, {
  group = vim.api.nvim_create_augroup('ClearPostSpaces', { clear = true }),
  pattern = '*',
  command = [[%s/\s\+$//e]],
})

-- Disable some options in terminal mode
vim.api.nvim_create_autocmd('TermOpen', {
  group = vim.api.nvim_create_augroup('TerminalMode', { clear = true }),
  pattern = '*',
  callback = function()
    vim.o.spell = false
    vim.wo.signcolumn = 'yes'
  end,
})

-- Muscle memory
vim.api.nvim_create_user_command('E', function()
  -- vim.cmd 'Explore'
  -- vim.cmd 'Oil'
end, {})

vim.api.nvim_create_user_command('ToggleQuickfix', function()
  local qf_exists = false
  for _, win in pairs(vim.fn.getwininfo()) do
    if win['quickfix'] == 1 then
      qf_exists = true
    end
  end
  if qf_exists then
    vim.cmd 'cclose'
    return
  end
  if not vim.tbl_isempty(vim.fn.getqflist()) then
    vim.cmd 'copen'
  else
    print 'Quickfix list is empty'
  end
end, {})

vim.keymap.set('n', '<leader>q', function()
  vim.cmd 'ToggleQuickfix'
end, { noremap = true, silent = true })

-- MS Windows shenanigans
vim.o.isfname = '@,48-57,/,.,-,_,+,,,#,$,%,~,=,(,),[,]'
if vim.fn.has 'win32' then
  vim.o.shellslash = true
  vim.o.completeslash = 'slash'
end

-- Neovide setup for easier jumpstart in OS Windows
if vim.g.neovide then
  vim.g.neovide_fullscreen = true
  vim.g.neovide_cursor_trail_size = 0.2
  vim.g.neovide_cursor_animate_command_line = false
end

-- vim: ts=2 sts=2 sw=2 et
