source ~/git-repos/dotfiles/vim/autoload/pathogen.vim

execute pathogen#infect('bundle/{}', '~/git-repos/dotfiles/vim/bundle/{}')

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
