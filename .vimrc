" Vundle
set nocompatible

set rtp+=~/.vim/bundle/Vundle.vim
set rtp+=~/.vim/plugged/syntastic
set rtp+=~/.vim/plugged/lightline.vim
call vundle#begin('~/.vim/plugged/vundle')

" PLUGINS LIST ===============================================================
Plugin 'VundleVim/Vundle.vim'

" Visual theme
Plugin 'dracula/vim', { 'name': 'dracula' }

" Visual status line
Plugin 'itchyny/lightline.vim'
Plugin 'ryanoasis/vim-devicons'

" File handlers
Plugin 'scrooloose/nerdtree' " file viewer
Plugin 'jistr/vim-nerdtree-tabs' " make nerd tree feel like a panel
Plugin 'kien/ctrlp.vim' " file jumper 
Plugin 'tiagofumo/vim-nerdtree-syntax-highlight' " Syntax highlighting for nerd tree

" Git
Plugin 'tpope/vim-fugitive'
Plugin 'junegunn/gv.vim'

" Language support
Plugin 'neoclide/coc.nvim', {'branch': 'release'}

" Python
Plugin 'vim-scripts/indentpython.vim' " Python indentation

" Web dev
Plugin 'mattn/emmet-vim'
Plugin 'digitaltoad/vim-pug' " HTML syntax hightlight
Plugin 'ap/vim-css-color'
Plugin 'Glench/Vim-Jinja2-Syntax'

" Javascript
Plugin 'pangloss/vim-javascript'
Plugin 'ternjs/tern_for_vim'

" Easy good-looking code
Plugin 'jiangmiao/auto-pairs' " Auto close
Plugin 'tpope/vim-surround' " Handle pairs
Plugin 'tpope/vim-repeat' " Enhance dot commands
Plugin 'tpope/vim-commentary' " Code comments
Plugin 'tmhedberg/SimpylFold' " Fold code
Plugin 'vim-syntastic/syntastic' " Write syntactically well please
Plugin 'nvie/vim-flake8' " Python PEP8 antidote
Plugin 'jelera/vim-javascript-syntax' " Javascript syntax
Plugin 'sheerun/vim-polyglot'

" Auto completion
Plugin 'davidhalter/jedi-vim'
Plugin 'Shougo/deoplete.nvim'
Plugin 'deoplete-plugins/deoplete-jedi'

call vundle#end()

" BASIC CONFIGURATION ========================================================
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

" bind Ctrl + movement kets to move around the windows, instead of using Ctrl+w+movement
nnoremap <A-j> <C-W><C-J>
nnoremap <A-k> <C-W><C-K>
nnoremap <A-l> <C-W><C-L>
nnoremap <A-h> <C-W><C-H>

" Insert only a character without switching to insert mode
nnoremap <Space> i_<Esc>r

" Easier moving between tabs
"noremap <Leader>n <esc>:tabprevious<CR>
"noremap <Leader>m <esc>:tabnext<CR>
noremap <C-d> :tabnext<CR>
noremap <C-s> :tabprevious<CR>
noremap <C-t> :tabnew<CR>
inoremap <C-d> <Esc>:tabnext<CR>
inoremap <C-s> <Esc>:tabprevious<CR>
inoremap <C-t> <Esc>:tabnew<CR>

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
syntax enable

" Color scheme
" Disable background highlight to use terminal's BG
au ColorScheme * hi Normal ctermbg=None
colorscheme dracula " Use dracula theme

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
	\ set tabstop=4 |
	\ set softtabstop=4 |
	\ set shiftwidth=4 |
    \ set textwidth=80 |

" Unfold all when open a file
au BufWinEnter * normal zR

" Terminal
command! -nargs=* T split | terminal <args>
command! -nargs=* VT vsplit | terminal <args>
tnoremap <Esc> <C-\><C-n>
noremap <A-t> :vsplit+terminal<CR>
au TermOpen * setlocal nonumber norelativenumber


" PLUGINS CONFIGURATION =======================================================

" Git-fugitive -----------------------------------------------
nmap <leader>gs :vertical Gstatus<cr>gg<C-n>
nmap <leader>gd :vertical Gdiff<CR>

let g:SimpylFold_docstring_preview=1

" Lightline -------------------------------------------------
highlight clear CursorLine " Removes the underline causes by enabling cursorline
let g:lightline = {
  \ 'colorscheme': 'dracula',
  \   'active': {
  \     'left':[ [ 'mode', 'paste' ],
  \              [ 'gitbranch', 'readonly', 'filename', 'modified', 'cocstatus' ]
  \     ]
  \   },
	\   'component': {
	\     'lineinfo': ' %3l:%-2v',
	\   },
  \   'component_function': {
  \     'gitbranch': 'fugitive#head',
  \     'cocstatus': 'coc#status',
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

" NERDTRee ----------------------------------------------------
let NERDTreeIgnore=['\.pyc$', '\~$']
let NERDTreeShowHidden = 1
let NERDTreeDirArrows = 1
let NERDTreeHijackNetrw = 1
let g:NERDTreeWinSize=40
let NERDTreeMapOpenInTab='\r'
"map <C-t> :NERDTreeToggle<CR>

autocmd StdinReadPre * let s:std_in=1
"autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in") | exe 'NERDTree' argv()[0] | wincmd p | ene | q | endif
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
nmap <A-e> :NERDTreeFocus<cr>R<C-W><C-P>:CtrlPClearAllCaches<CR>
map <C-e> :NERDTreeTabsToggle<CR>

" Nerd tree highlighting
let g:NERDTreeFileExtensionHighlightFullName = 1
let g:NERDTreeExactMatchHighlightFullName = 1
let g:NERDTreePatternMatchHightlightFullName = 1

" Syntastic ---------------------------------------------------
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 0
let g:syntastic_check_on_wq = 0
let g:syntastic_enable_highlighting = 0

let g:syntastic_javascript_checkers=['eslint']

" Delay the execution of lightline#update() so that SyntasticCheck got executed
" first, which avoid missing 'MODE' of lightline
function! SyntasticCheckHook(errors)
    call timer_start(10, {_->lightline#update()})
endfunction

let python_highlight_all=1

" Ctrlp --------------------------------------------------
let g:ctrlp_max_height=30
set wildignore+=*.pyc
set wildignore+=*_build/*
set wildignore+=*/coverage/*
set wildignore+=*/node_modules/*

" Jedi-vim ----------------------------------------------
let g:jedi#completions_enabled = 0
let g:jedi#use_splits_not_buffers = "right"
let g:jedi#usages_command = "<leader>z"
let g:jedi#popup_on_dot = 0
let g:jedi#popup_select_first = 0

" Deoplete ----------------------------------------------
let g:deoplete#enable_at_startup = 0

" Emmet -------------------------------------------------
let g:user_emmet_install_global = 0
autocmd FileType html,css EmmetInstall
let g:user_emmet_leader_key=','

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

" Coc
set hidden
set nobackup
set nowritebackup
set cmdheight=2
set updatetime=300
set shortmess+=c
set signcolumn=yes

inoremap <silent><expr> <C-space> coc#refresh()

" Tab completion
inoremap <expr><TAB> 
    \ pumvisible() ? "\<C-n>" :
    \ <SID>check_back_space() ? "\<TAB>" :
    \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
    let col = col('.') - 1
    return !col || getline('.')[col - 1] =~# '\s'
endfunction

