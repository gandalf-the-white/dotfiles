"$ git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
"YouCompleteMe (golang)
"https://github.com/Valloric/YouCompleteMe/issues/3074


set encoding=utf-8
set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

"My Plugins here:
Plugin 'scrooloose/nerdtree.git'
Plugin 'Xuyuanp/nerdtree-git-plugin'
Plugin 'scrooloose/nerdcommenter'
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'altercation/vim-colors-solarized'
Plugin 'Lokaltog/vim-distinguished'
Plugin 'pangloss/vim-javascript'
Plugin 'nathanaelkane/vim-indent-guides'
Plugin 'Raimondi/delimitMate'
" Plugin 'moll/vim-node'
" Plugin 'chase/vim-ansible-yaml'
Plugin 'mrk21/yaml-vim'
Plugin 'tmhedberg/SimpylFold'
Plugin 'jnurmine/Zenburn'
Plugin 'majutsushi/tagbar'
Plugin 'godlygeek/tabular'
Plugin 'plasticboy/vim-markdown'
Plugin 'tpope/vim-fugitive'
Plugin 'vim-scripts/awk.vim'
Plugin 'vim-scripts/DoxygenToolkit.vim'
Plugin 'fatih/vim-go'
Plugin 'Valloric/YouCompleteMe'
" Plugin 'LaTeX-Suite-aka-Vim-LaTeX'
Plugin 'drewtempelmeyer/palenight.vim'
Plugin 'xuhdev/vim-latex-live-preview'
Plugin 'Yggdroot/indentLine'

" All of your Plugins must be added before the following line
call vundle#end()            " required

filetype plugin indent on    " required

" Leader
" We redefine the key leader
:let mapleader = ";"

"NERDTree
" map <C-n> :NERDTreeToggle<CR>
map <leader>f :NERDTreeToggle<CR>
nnoremap <silent> <Leader>v :NERDTreeFind<CR>

"NERDCommenter
let g:NERDSpaceDelims = 1
let NERDTreeQuitOnOpen = 1

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
" we select '; l' to toggle the tagbar
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

if $COLORTERM == 'gnome-terminal'
    set t_Co=256
endif
set t_ut=


" YouCompleteMe
" Start autocompletion after 4 chars
let g:ycm_min_num_of_chars_for_completion = 4
let g:ycm_min_num_identifier_candidate_chars = 4
let g:ycm_enable_diagnostic_highlighting = 0
" Don't show YCM's preview window [ I find it really annoying ]
set completeopt-=preview
let g:ycm_add_preview_to_completeopt = 0

autocmd Filetype tex setl updatetime=1
" let g:livepreview_previewer = 'open -a Preview'
let g:tex_flavor='latex'
let g:Tex_TreatMacViewerAsUNIX = 1
let g:Tex_DefaultTargetFormat = 'pdf'
let g:Tex_CompileRule_pdf = 'pdflatex -synctex=1 --interaction=nonstopmode $*'
" let g:Tex_ViewRule_pdf='open -a Skim'
let g:livepreview_previewer = 'open -a Skim'
"
" Yaml
au! BufNewFile,BufReadPost *.{yaml,yml} set filetype=yaml foldmethod=indent
autocmd FileType yaml setlocal ts=2 sts=2 sw=2 expandtab
" Solarized
syntax enable
set number
set background=dark
" let g:solarized_termtrans=1
" let g:solarized_termcolors=256
" let g:solarized_visibility= "high"
" let g:solarized_contrast = "high"

set list
" set listchars=tab:>-,trail:-,extends:#,nbsp:-
" set list lcs=trail:·,tab:»·
" set listchars=tab:→\ ,trail:·,precedes:«,extends:»,eol:¶
" set listchars=tab:→\ ,trail:␣,extends:…,eol:⏎
" set listchars=tab:‣\ ,trail:·,precedes:«,extends:»,eol:¬
" set listchars=tab:>-,trail:.,precedes:<,extends:>,eol:$
set listchars=tab:‣-,trail:.,precedes:<,extends:>,eol:⏎
set modeline
set tabstop=4 expandtab shiftwidth=4 softtabstop=4
" set et sw=4 sts=4

" Indentline
let g:indentLine_setColors = 1
" let g:indentLine_color_term = 239
" let g:indentLine_char = '│'
let g:indentLine_char = '┊'
let g:indentLine_concealcursor = 'inc'
let g:indentLine_conceallevel = 2

" colorscheme zenburn
colorscheme palenight

" Italics for my favorite color scheme
let g:palenight_terminal_italics=1
