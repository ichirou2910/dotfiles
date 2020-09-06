" Vundle
set nocompatible

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin('~/.vim/plugged/vundle')

" PLUGINS LIST ===============================================================
Plugin 'VundleVim/Vundle.vim'
" Visual theme
Plugin 'drewtempelmeyer/palenight.vim'
Plugin 'mhartington/oceanic-next'
call vundle#end()

" BASIC CONFIGURATION ========================================================
"
" Set leader shortcut
let mapleader = ","

" Auto reload vimrc when saved
autocmd! bufwritepost .vimrc ++nested source %

" Enable swap files
set swapfile
set dir=~/.swap-files

" Bind :nohl <- removes highlight of last search
noremap <C-n> :nohl<CR>
vnoremap <C-n> <Esc>:nohl<CR>
inoremap <C-n> <Esc>:nohl<CR>

" bind Ctrl + movement kets to move around the windows, instead of using Ctrl+w+movement
nnoremap <C-j> <C-W><C-J>
nnoremap <C-k> <C-W><C-K>
nnoremap <C-l> <C-W><C-L>
nnoremap <C-h> <C-W><C-H>

" Insert only a character without switching to insert mode
nnoremap <Space> i_<Esc>r

" Vim sort function
vnoremap <Leader>s :sort<CR>

" Easier moving of code blocks
vnoremap < <gv
vnoremap > >gv

" Tabs movement
noremap <C-d> :tabnext<CR>
noremap <C-s> :tabprevious<CR>
noremap <C-t> :tabnew<CR>
inoremap <C-d> <Esc>:tabnext<CR>
inoremap <C-s> <Esc>:tabprevious<CR>
inoremap <C-t> <Esc>:tabnew<CR>

" Buffers movement
nnoremap <leader>] :bn<CR>
nnoremap <leader>[ :bp<CR>

" Search for visually selected text
vnoremap // y/\V<C-R>=escape(@",'/\')<CR><CR>

let g:python3_host_prog = "$HOME/.virtualenvs/.neovim3/bin/python"

" Some other stuff
set mouse=a
set showmatch
set showcmd
set cursorline

set virtualedit=onemore
set autoindent
set nofoldenable
set wildmenu
set confirm

set encoding=utf-8
set fileencoding=utf-8
set fileencodings=utf-8
set clipboard=unnamed

set history=700
set undolevels=700

set backspace=indent,eol,start

set nofixendofline

" Window title
set title
set titleold="Terminal"
set titlestring=%F

" Tabs
set tabstop=4
set softtabstop=0
set shiftwidth=4
set shiftround
set expandtab
set laststatus=2
set splitright
set splitbelow

" Search
set hlsearch
set incsearch
set ignorecase
set smartcase
" display matched at the middle of the screen
nnoremap n nzzzv
nnoremap N Nzzzv

set fileformats=unix,dos

" Enable syntax highlighting
filetype off
filetype plugin on
syntax enable

" Enable true color support
if exists('+termguicolors')
    let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
    let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
    set termguicolors
endif
" Disable background highlight to use terminal's BG
" colorscheme palenight
let g:oceanic_next_terminal_italic = 1
let g:oceanic_next_terminal_bold = 1
colorscheme OceanicNext
hi! Normal ctermbg=None guibg=None
hi! NonText ctermbg=None guibg=None
hi! VertSplit ctermbg=NONE ctermfg=NONE guibg=#00afff guifg=#000000
hi! Comment cterm=italic ctermbg=NONE guibg=NONE
hi! LineNr guibg=NONE
hi! CursorLineNr ctermbg=236 ctermfg=NONE guibg=#303030
hi! CursorLine ctermbg=236 ctermfg=NONE guibg=#303030
hi! SignColumn ctermbg=NONE guibg=NONE
hi! Folded ctermbg=NONE guibg=NONE
hi! EndOfBuffer ctermbg=NONE ctermfg=NONE guibg=NONE guifg=#080808
hi! WildMenu ctermfg=226 ctermbg=0 guifg=#ffff00 guibg=#000000

" Show line numbers and length
set rnu
set number
set nowrap

" C indentation
au BufNewFile,BufRead *.c,*.cpp,*.h,*.hpp,*.php
    \ set tabstop=4 |
    \ set softtabstop=4 |
    \ set shiftwidth=4 |
    \ set noexpandtab |
    \ set colorcolumn=110 |

" Python indentation
au BufNewFile,BufRead *.py
	\ set tabstop=8 |
	\ set softtabstop=4 |
	\ set shiftwidth=4 |
    \ set colorcolumn=79 |
	\ set expandtab |
	\ set autoindent |

" For full stack dev
au BufNewFile,BufRead *.html,*.css,*.js,*.json
	\ set tabstop=2 |
	\ set shiftwidth=2 |
    \ set expandtab |

" Unfold all when open a file
au BufWinEnter * normal zR

" Terminal
if has("nvim")
    au TermOpen * tnoremap <buffer> <Esc> <C-\><C-n>
    au FileType fzf tunmap <buffer> <Esc>
endif
