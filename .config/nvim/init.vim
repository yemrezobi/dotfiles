call plug#begin()

Plug 'bronson/vim-trailing-whitespace'
Plug 'chriskempson/tomorrow-theme', { 'rtp': 'vim' }
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-surround'
Plug 'airblade/vim-gitgutter'
Plug 'neovim/nvim-lspconfig'
Plug 'jackguo380/vim-lsp-cxx-highlight'
Plug 'ms-jpq/coq_nvim', {'branch': 'coq'}
Plug 'ms-jpq/coq.artifacts', {'branch': 'artifacts'}
Plug 'kyazdani42/nvim-web-devicons'
Plug 'folke/trouble.nvim'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'edkolev/tmuxline.vim'
Plug 'lukas-reineke/indent-blankline.nvim'
Plug 'windwp/nvim-autopairs'
Plug 'nvim-tree/nvim-tree.lua'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim', { 'tag': '0.1.x' }
Plug 'windwp/nvim-ts-autotag'
Plug 'gpanders/editorconfig.nvim'
Plug 'romainl/vim-devdocs'
Plug 'ray-x/lsp_signature.nvim'

call plug#end()

let g:coq_settings = { 'auto_start': 'shut-up' }

lua require('config')

let g:loaded_ruby_provider = 0
let g:loaded_perl_provider = 0
let g:python3_host_prog = '/usr/bin/python3'
let g:airline_powerline_fonts = 1

filetype plugin indent on
" show existing tab with 4 spaces width
set tabstop=4
" when indenting with '>', use 4 spaces width
set shiftwidth=4
" On pressing tab, insert 4 spaces
set expandtab

" line numbers
set number

set mouse=

" enable 24-bit colors
set termguicolors
colorscheme Tomorrow-Night
"hi Normal guibg=none

" map enter to clear search highlighting
nnoremap <silent> <esc> :noh<return><esc>

set keywordprg=:DD!
