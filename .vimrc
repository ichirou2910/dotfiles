" Vundle
set nocompatible

set rtp+=~/.vim/bundle/Vundle.vim
set rtp+=~/.vim/plugged/syntastic
set rtp+=~/.vim/plugged/lightline.vim
call vundle#begin('~/.vim/plugged/vundle')

" PLUGINS LIST ===============================================================
Plugin 'VundleVim/Vundle.vim'

" Snippets
Plugin 'SirVer/ultisnips'
Plugin 'honza/vim-snippets'

" Visual theme
Plugin 'dracula/vim', { 'name': 'dracula' }
Plugin 'drewtempelmeyer/palenight.vim'

" Visual status line
Plugin 'itchyny/lightline.vim'
Plugin 'ryanoasis/vim-devicons'
Plugin 'morhetz/gruvbox'
Plugin 'ayu-theme/ayu-vim'

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
Plugin 'ap/vim-css-color'

" Javascript
Plugin 'pangloss/vim-javascript'
Plugin 'ternjs/tern_for_vim'

" Easy good-looking code
Plugin 'sheerun/vim-polyglot' " Support multiple languages
Plugin 'jiangmiao/auto-pairs' " Auto close
Plugin 'tpope/vim-surround' " Handle pairs
Plugin 'tpope/vim-repeat' " Enhance dot commands
Plugin 'tpope/vim-commentary' " Code comments
Plugin 'tmhedberg/SimpylFold' " Fold code
Plugin 'vim-syntastic/syntastic' " Write syntactically well please
Plugin 'nvie/vim-flake8' " Python PEP8 antidote

Plugin 'digitaltoad/vim-pug' " HTML syntax hightlight
Plugin 'jelera/vim-javascript-syntax' " Javascript syntax

" Plugin 'vim-scripts/django.vim'
Plugin 'tweekmonster/django-plus.vim' " Syntax highlighting for django html

" Auto completion
Plugin 'davidhalter/jedi-vim'
Plugin 'Shougo/deoplete.nvim'
Plugin 'deoplete-plugins/deoplete-jedi'

" Note taking
Plugin 'vimwiki/vimwiki' 
Plugin 'iamcco/markdown-preview.nvim', {'do' : 'cd app && yarn install'}
Plugin 'godlygeek/tabular'
Plugin 'plasticboy/vim-markdown'

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
filetype plugin on
syntax enable

" Enable true color support
if exists('+termguicolors')
  let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
  let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
  set termguicolors
endif
" Disable background highlight to use terminal's BG
" au ColorScheme * hi Normal guibg=None
" Color scheme
colorscheme palenight
hi Normal guibg=None

" Show line numbers and length
set rnu
set number
set nowrap

" Show bad white space
" au BufRead,BufNewFile *.py,*.pyw,*.c,*.h match BadWhitespace /\s\+$/

" Python indentation
au BufNewFile,BufRead *.py
	\ set tabstop=4 |
	\ set softtabstop=4 |
	\ set shiftwidth=4 |
	\ set expandtab |
	\ set autoindent |
	\ set fileformat=unix |

" For full stack dev
au BufNewFile,BufRead *.js,*.html,*.css
	\ set tabstop=4 |
	\ set softtabstop=4 |
	\ set shiftwidth=4 |

" Unfold all when open a file
au BufWinEnter * normal zR

au FileType vimwiki set syntax=markdown

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
  \ 'colorscheme': 'palenight',
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
  \     'filename': 'LightlineFilename',
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

function! LightlineFilename()
    let root = fnamemodify(get(b:, 'git_dir'), ':h')
    let path = expand('%:p')
    if path[:len(root)-1] ==# root
        return path[len(root)+1:]
    endif
    return expand('%')
endfunction

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

let g:syntastic_python_pylint_post_args="--rcfile=~/.pylintrc"
let g:syntastic_javascript_checkers=['eslint']
let g:syntastic_html_tidy_ignore_errors=["trimming empty <",
                    \ "<img> escaping malformed URI reference",
                    \ "plain text isn't allowed in <",
                    \ "illegal characters found in URI",
                    \ "unexpected <"]

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
autocmd FileType html,htmldjango,css EmmetInstall
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

nmap <silent> <leader>cd :CocList diagnostics<CR>
nmap <silent> <leader>n <Plug>(coc-diagnostic-prev)
nmap <silent> <leader>m <Plug>(coc-diagnostic-next)

nmap <silent> <leader>dd :vs<CR><Plug>(coc-definition)
nmap <silent> <leader>dr :vs<CR><Plug>(coc-references)
nmap <silent> <leader>di :vs<CR><Plug>(coc-implementation)

" Vim-wiki
let g:vimwiki_ext2syntax = {'.md': 'markdown', '.markdown': 'markdown', '.mdown': 'markdown'}
let g:vimwiki_table_mappings = 0
let g:vimwiki_global_ext = 0
nmap <leader>wf <Plug>VimwikiFollowLink
nmap <leader>wb <Plug>VimwikiGoBackLink
nmap <leader>wn <Plug>VimwikiNextLink
nmap <leader>wp <Plug>VimwikiPrevLink

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

" Ultisnips
let g:UltiSnipsExpandTrigger = '<C-z>'
let g:UltiSnipsJumpForwardTrigger = '<C-z>'
let g:UltiSnipsJumpBackwardTrigger = '<C-b>'

" Vim-instant-markdown --------------------------------------
let g:instant_markdown_autostart = 1
map <leader>md :InstantMarkdownPreview<CR>
let g:instant_markdown_mathjax = 1

" Vim-markdown
let g:vim_markdown_no_default_key_mappings = 0
let g:vim_markdown_frontmatter = 1

" Markdown-preview
let g:mkdp_browser = 'firefox'
let g:mkdp_auto_closer = 0
