set et sw=3 sts=3 

set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

"My Plugins here:
Plugin 'scrooloose/nerdtree.git'
Plugin 'altercation/vim-colors-solarized'
Plugin 'Lokaltog/vim-distinguished'
Plugin 'pangloss/vim-javascript'
Plugin 'nathanaelkane/vim-indent-guides'
Plugin 'Raimondi/delimitMate'
Plugin 'moll/vim-node'
Plugin 'digitaltoad/vim-jade'

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required

"NERDTree
map <C-n> :NERDTreeToggle<CR>

"Delimiter
imap <C-c> <CR><Esc>O

" Solarized
syntax enable
" set number
set background=dark
let g:solarized_termcolors=256
let g:solarized_visibility= "high"
let g:solarized_contrast = "high"
colorscheme solarized

" colorscheme distinguished
