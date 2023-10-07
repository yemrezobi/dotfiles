vim.g.mapleader = ' '
vim.g.loaded_ruby_provider = 0
vim.g.loaded_perl_provider = 0
vim.g.python3_host_prog = '/usr/bin/python3'
vim.g.airline_powerline_fonts = 1
vim.g.splitleft = true

vim.o.scrolloff = 5
vim.o.tabstop = 4
vim.o.shiftwidth = vim.o.tabstop
vim.o.expandtab = true
vim.o.number = true
vim.o.mouse = 'nv'
vim.o.termguicolors = true
vim.o.cursorline = true

-- highlight whitespace at end of lines
vim.fn.matchadd('errorMsg', [[\s\+$]])
