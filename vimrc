source ~/dotfiles/vim/autoload/pathogen.vim

execute pathogen#infect('bundle/{}', '~/dotfiles/vim/bundle/{}')

set nocompatible

" Indentation
"
set autoindent
set smartindent
set smarttab
set shiftwidth=2
set softtabstop=2
set tabstop=2
set expandtab

"
" Syntax
"
syntax on

"
" Filetype settings
"
filetype plugin on
filetype indent on

"
"" Search
"
set incsearch
set hlsearch
"
""
" Statusline
" "
set laststatus=2
set statusline=%<%f\ %(\ [%M%R%H%Y]%)%=%-14.(%l,%c%V%)\ %P
"
" "
" " Autoreload
" "
autocmd! bufwritepost .vimrc source %
"
let g:syntastic_puppet_puppetlint_args = '--no-80chars-check'

let g:Powerline_symbols = 'fancy'
set encoding=utf-8
set t_Co=256
set fillchars+=stl:\ ,stlnc:\
let g:Powerline_mode_V="V·LINE"
let g:Powerline_mode_cv="V·BLOCK"
let g:Powerline_mode_S="S·LINE"
let g:Powerline_mode_cs="S·BLOCK"

autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
map <C-n> :NERDTreeToggle<CR>
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif
