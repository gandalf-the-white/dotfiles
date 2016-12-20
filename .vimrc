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
Plugin 'scrooloose/nerdcommenter'
Plugin 'altercation/vim-colors-solarized'
Plugin 'Lokaltog/vim-distinguished'
Plugin 'pangloss/vim-javascript'
Plugin 'nathanaelkane/vim-indent-guides'
Plugin 'Raimondi/delimitMate'
Plugin 'moll/vim-node'
Plugin 'digitaltoad/vim-jade'
Plugin 'chase/vim-ansible-yaml'
Plugin 'tmhedberg/SimpylFold'
Plugin 'jnurmine/Zenburn'
Plugin 'davidhalter/jedi-vim'
Plugin 'majutsushi/tagbar'

" All of your Plugins must be added before the following line
call vundle#end()            " required

filetype plugin indent on    " required

"Leader
:let mapleader = ";"

"NERDTree
map <C-n> :NERDTreeToggle<CR>

"NERDCommenter
let g:NERDSpaceDelims = 1

"Delimiter
imap <C-c> <CR><Esc>O

"YAML
let g:ansible_options = {'ignore_blank_lines': 0}

" Enable folding
set foldmethod=indent
set foldlevel=99

" Enable folding with the spacebar
nnoremap <space> za

let g:SimpylFold_docstring_preview = 1

" TagBar
" nmap <F8> :TagbarToggle<CR>
let g:tagbar_usearrows = 1
nnoremap <leader>l :TagbarToggle<CR>

set t_Co=256

" Solarized
syntax enable
set number
set background=dark
let g:solarized_termtrans=1
let g:solarized_termcolors=256
let g:solarized_visibility= "high"
let g:solarized_contrast = "high"

colorscheme zenburn

