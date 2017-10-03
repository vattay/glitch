execute pathogen#infect()

syntax enable   "enable syntax processing
set t_Co=16
set background=dark
colorscheme solarized

filetype plugin indent on
set tabstop=4       " Number of visual spaces per TAB
set softtabstop=4   " Number of spaces in tab when editing
set shiftwidth=4    " Number of spaces for indentation
set expandtab       " Change tabs to spaces

set number          " show line numbers
set relativenumber

set wildmenu
set showmatch       " show matching [{(

set incsearch       " incremental search
set hlsearch        " highlight search

set foldenable      " enable folding
set foldlevelstart=10
set foldnestmax=10

nnoremap gV `[v`]

