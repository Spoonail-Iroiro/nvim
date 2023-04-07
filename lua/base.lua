require('help-curwin')

local Plug = vim.fn['plug#']

vim.call('plug#begin', '~/.config/nvim/plugged')

    Plug('neoclide/coc.nvim', {branch = 'release'})
    Plug 'lambdalisue/fern.vim'
    Plug 'lambdalisue/fern-mapping-git.vim'
    Plug 'lambdalisue/fern-git-status.vim'
    Plug('nvim-treesitter/nvim-treesitter', {['do'] = ':TSUpdate'})
    Plug 'jiangmiao/auto-pairs'
    Plug 'windwp/nvim-ts-autotag'
    Plug 'tpope/vim-fugitive'
    Plug 'rebelot/kanagawa.nvim'

vim.call('plug#end')

vim.opt.fileencodings={'utf-8','sjis','cp932','euc-jp'}
vim.opt.clipboard:append('unnamedplus')
vim.opt.cursorline = true
vim.opt.number = true
vim.opt.expandtab = true
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.softtabstop = -1
vim.opt.autoindent = true
vim.opt.smartindent = true
vim.opt.ignorecase = true
vim.opt.smarttab = true
vim.opt.ignorecase = true
vim.opt.wrap = true
-- vim.opt.showtabline = 2
-- vim.opt.termguicolors = true
vim.opt.backup = false
vim.opt.swapfile = false

vim.cmd('colorscheme kanagawa')

-- Leader key
vim.keymap.set('n', ' ', '<Nop>')
vim.g.mapleader = ' '

-- Open init.lua by F1
vim.keymap.set('n','<F1>',':edit $MYVIMRC<CR>')

-- Window split
vim.keymap.set('n', 'sh', '<C-w>h')
vim.keymap.set('n', 'sk', '<C-w>k')
vim.keymap.set('n', 'sj', '<C-w>j')
vim.keymap.set('n', 'sl', '<C-w>l')
vim.keymap.set('n', 's', '<Nop>')
vim.keymap.set('n', 'ss', ':split<Return><C-w>w')
vim.keymap.set('n', 'sv', ':vsplit<Return><C-w>w')
vim.keymap.set('n', 'sW', '<C-w>p')

-- Move half by <C-f>/<C-b>
vim.keymap.set('n', '<C-f>', '<C-d>')
vim.keymap.set('n', '<C-b>', '<C-u>')

-- Avoid press c in diff
vim.keymap.set('n', '<Leader>]', ']c')
vim.keymap.set('n', '<Leader>[', '[c')

-- Tab util (close quick...)
vim.keymap.set('n', '[tabutil]', '<Nop>')
vim.keymap.set('n', '<Leader>t', '[tabutil]', {remap=true})
vim.keymap.set('n', '[tabutil]c', '<Cmd>tabclose<CR>')


