" Vundle
set nocompatible

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin('~/.vim/plugged/vundle')

" Plugin Lists ===============================================================
Plugin 'VundleVim/Vundle.vim'

" Visual theme
Plugin 'dracula/vim', { 'name': 'dracula' }

" Visual status line
Plugin 'itchyny/lightline.vim'
Plugin 'ryanoasis/vim-devicons'

" File handlers
Plugin 'scrooloose/nerdtree' " file viewer
Plugin 'kien/ctrlp.vim' " file jumper

" Git
Plugin 'tpope/vim-fugitive'
Plugin 'junegunn/gv.vim'

" Easy good-looking code
Plugin 'jiangmiao/auto-pairs' " Auto close 
Plugin 'tpope/vim-surround' " Handle pairs 
Plugin 'tpope/vim-repeat' " Enhance dot commands
Plugin 'tmhedberg/SimpylFold' " Fold code
Plugin 'vim-scripts/indentpython.vim' " Python indentation
Plugin 'vim-syntastic/syntastic' " Write syntactically well please
Plugin 'nvie/vim-flake8' " Python PEP8 antidote

Plugin 'scrooloose/nerdcommenter'

" Auto completion
Plugin 'davidhalter/jedi-vim'
Plugin 'Shougo/deoplete.nvim'
Plugin 'deoplete-plugins/deoplete-jedi'

call vundle#end()

" Basic Configuration ========================================================
"
" Set leader shortcut
let mapleader = ","

" Auto reload vimrc when saved
autocmd! bufwritepost .vimrc source %

" Enable swap files
set swapfile
set dir=~/.swap-files

" Bind :nohl <- removes highlight of last search
noremap <C-n> :nohl<CR>
vnoremap <C-n> :nohl<CR>
inoremap <C-n> :nohl<CR>

" Map keys (conflicted with tmux so not used anymore)
"nnoremap <C-Down> <C-W><C-J>
"nnoremap <C-Up> <C-W><C-K>
"nnoremap <C-Right> <C-W><C-L>
"nnoremap <C-Left> <C-W><C-H>

" bind Ctrl + movement kets to move around the windows, instead of using Ctrl+w+movement
" (conflicted with tmux so not used anymore)
"nnoremap <C-J> <C-W><C-J>
"nnoremap <C-K> <C-W><C-K>
"nnoremap <C-H> <C-W><C-L>
"nnoremap <C-L> <C-W><C-H>

" Insert only a character without switching to insert mode
nnoremap <Space> i_<Esc>r

" Easier moving between tabs
noremap <Leader>n <esc>:tabprevious<CR>
noremap <Leader>m <esc>:tabnext<CR>

" Vim sort function
vnoremap <Leader>s :sort<CR>

" Easier moving of code blocks
vnoremap < <gv
vnoremap > >gv

" Some other stuff
set mouse=a
set showmatch
set showcmd
set cursorline

set virtualedit=onemore
set autoindent
set foldmethod=indent
set textwidth=80
set wildmenu
set confirm

set encoding=utf-8
set clipboard=unnamed

set history=700
set undolevels=700

" Tabs
set tabstop=4
set softtabstop=4
set shiftwidth=4
set shiftround
set expandtab
set laststatus=2
set splitright
set splitbelow

" Enable syntax highlighting
filetype off
filetype plugin indent on
syntax on

" Show line numbers and length
set rnu
set number
set nowrap

" Show bad white space
highlight BadWhitespace ctermbg=red guibg=red
au BufRead,BufNewFile *.py,*.pyw,*.c,*.h match BadWhitespace /\s\+$/

" Python indentation
au BufNewFile,BufRead *.py
	\ set tabstop=4 |
	\ set softtabstop=4 |
	\ set shiftwidth=4 |
	\ set expandtab |
	\ set autoindent |
	\ set textwidth=80 |
	\ set fileformat=unix |
    \ set colorcolumn=80 |

" For full stack dev
au BufNewFile,BufRead *.js,*.html,*.css
	\ set tabstop=2 |
	\ set softtabstop=2 |
	\ set shiftwidth=2 |
    \ set textwidth=80 |

" Unfold all when open a file
au BufWinEnter * normal zR

" Git-fugitive stuff
nmap <leader>g :Gstatus<cr>gg<C-n>

let g:SimpylFold_docstring_preview=1
let NERDTreeIgnore=['\.pyc$', '\~$']

" Lightline -------------------------------------------------
highlight clear CursorLine " Removes the underline causes by enabling cursorline
let g:lightline = {
  \   'colorscheme': 'dracula',
  \   'active': {
  \     'left':[ [ 'mode', 'paste' ],
  \              [ 'gitbranch', 'readonly', 'filename', 'modified' ]
  \     ]
  \   },
	\   'component': {
	\     'lineinfo': ' %3l:%-2v',
	\   },
  \   'component_function': {
  \     'gitbranch': 'fugitive#head',
  \   }
  \ }
let g:lightline.separator = {
	\   'left': '', 'right': ''
  \}
let g:lightline.subseparator = {
	\   'left': '', 'right': '' 
  \}
let g:lightline.tabline = {
  \   'left': [ ['tabs'] ],
  \   'right': [ ['close'] ]
  \ }
set showtabline=2  " Show tabline
set guioptions-=e  " Don't use GUI tabline
"------------------------------------------------------------

" NERDTRee
let NERDTreeShowHidden = 1
let NERDTreeDirArrows = 1
let NERDTreeHijackNetrw = 1
let g:NERDTreeWinSize=40
map <C-t> :NERDTreeToggle<CR>

autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in") | exe 'NERDTree' argv()[0] | wincmd p | ene | q | endif
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

" Syntastic ---------------------------------------------------
"set statusline+=%#warningmsg#
"set statusline+=%{SyntasticStatuslineFlag()}
"set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 0
let g:syntastic_check_on_wq = 0
let g:syntastic_enable_highlighting = 0

let python_highlight_all=1

" Ctrlp --------------------------------------------------
let g:ctrlp_max_height=30
set wildignore+=*.pyc
set wildignore+=*_build/*
set wildignore+=*/coverage/*

" Jedi-vim ----------------------------------------------
let g:jedi#completions_enabled = 0
let g:jedi#use_splits_not_buffers = "right"
let g:jedi#usages_command = "<leader>z"
let g:jedi#popup_on_dot = 0
let g:jedi#popup_select_first = 0

" Deoplete ----------------------------------------------
let g:deoplete#enable_at_startup = 1


" Omnicomplete
"set completeopt=longest,menuone
"function! OmniPopup(action)
"    if pumvisible()
"        if a:action == 'j'
"            return "\<C-N>"
"        elseif a:action == 'k'
"            return "\<C-P>"
"        endif
"    endif
"    return a:action
"endfunction
"
"inoremap <silent>j <C-R>=OmniPopup('j')<CR>
"inoremap <silent>k <C-R>=OmniPopup('k')<CR>


"Vimtex
let g:tex_flavor="latex"
let g:vimtex_view_general_viewer = 'zathura'


" Tab completion
inoremap <expr><TAB> pumvisible() ? "\<C-n>" : "\<TAB>"

