"$ git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim

set et sw=4 sts=4 

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
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
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
Plugin 'godlygeek/tabular'
Plugin 'plasticboy/vim-markdown'
Plugin 'tpope/vim-fugitive'
Plugin 'vim-scripts/awk.vim'

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

" Airline
let g:airline#extensions#tabline#enabled = 1
" let g:Powerline_symbols = 'fancy'
let g:airline_powerline_fonts = 1

if !exists('g:airline_symbols')
   let g:airline_symbols = {}
endif

let g:airline_left_sep = '»'
let g:airline_left_sep = '▶'
let g:airline_right_sep = '«'
let g:airline_right_sep = '◀'
let g:airline_symbols.linenr = '␊'
let g:airline_symbols.linenr = '␤'
let g:airline_symbols.linenr = '¶'
let g:airline_symbols.branch = '⎇'
let g:airline_symbols.paste = 'ρ'
let g:airline_symbols.paste = 'Þ'
let g:airline_symbols.paste = '∥'
let g:airline_symbols.whitespace = 'Ξ'

set t_Co=256

" Solarized
syntax enable
set number
set background=dark
" let g:solarized_termtrans=1
" let g:solarized_termcolors=256
" let g:solarized_visibility= "high"
" let g:solarized_contrast = "high"

colorscheme zenburn

