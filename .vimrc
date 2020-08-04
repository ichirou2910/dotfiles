" LIST OF CONFIGURED EXTENSIONS ==============================================
" Quick jump: @ + index
" 1. Coc.nvim
" 2. Lightline
" 3. NERDTRee
" 4. Fzf-vim
" 5. Tags
" 6. Ultisnips
" 7. VeBugger
" 8. Vim-session
" --------
" 0.1 Emmet (HTML)
" 0.2 vim-javascript (JS)
" 0.3 Markdown (MD)
" 0.0 Uncategorized

" Vundle
set nocompatible

set rtp+=~/.vim/bundle/Vundle.vim
set rtp+=~/.vim/plugged/lightline.vim
call vundle#begin('~/.vim/plugged/vundle')

" PLUGINS LIST ===============================================================
Plugin 'VundleVim/Vundle.vim'

" Snippets
Plugin 'SirVer/ultisnips'
Plugin 'honza/vim-snippets'

" Visual theme
Plugin 'drewtempelmeyer/palenight.vim'

" Visual status line
Plugin 'itchyny/lightline.vim'
Plugin 'ryanoasis/vim-devicons'

" File handlers
Plugin 'scrooloose/nerdtree' " file viewer
Plugin 'jistr/vim-nerdtree-tabs' " make nerd tree feel like a panel
Plugin 'Xuyuanp/nerdtree-git-plugin'
Plugin 'tiagofumo/vim-nerdtree-syntax-highlight' " Syntax highlighting for nerd tree

Plugin 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plugin 'junegunn/fzf.vim'

" Ssg Vim extension lord
Plugin 'tpope/vim-eunuch'

" Tags
" Plugin 'universal-ctags/ctags'
" Plugin 'ludovicchabant/vim-gutentags'

" Git
Plugin 'tpope/vim-fugitive'
Plugin 'junegunn/gv.vim'

" Language support
Plugin 'neoclide/coc.nvim', {'branch': 'release'}

" Debugger
Plugin 'Shougo/vimproc.vim'
Plugin 'idanarye/vim-vebugger'

"" Vim-Session
Plugin 'xolox/vim-misc'
Plugin 'xolox/vim-session'

" Python
Plugin 'vim-scripts/indentpython.vim' " Python indentation

" C
Plugin 'vim-scripts/c.vim', {'for': ['c', 'cpp']}

" HTML
Plugin 'mattn/webapi-vim'
Plugin 'mattn/emmet-vim'
Plugin 'ap/vim-css-color'
Plugin 'tpope/vim-haml'
Plugin 'hail2u/vim-css3-syntax'
Plugin 'gorodinskiy/vim-coloresque'
Plugin 'tweekmonster/django-plus.vim' " Syntax highlighting for django html

" Javascript
Plugin 'jelera/vim-javascript-syntax'

" Easy good-looking code
Plugin 'sheerun/vim-polyglot' " Support multiple languages
Plugin 'jiangmiao/auto-pairs' " Auto close
Plugin 'tpope/vim-surround' " Handle pairs
Plugin 'tpope/vim-repeat' " Enhance dot commands
Plugin 'tpope/vim-commentary' " Code comments
Plugin 'nvie/vim-flake8' " Python PEP8 antidote

" Plugin 'digitaltoad/vim-pug' " HTML syntax hightlight

" Note taking
Plugin 'iamcco/markdown-preview.nvim', {'do' : 'cd app && yarn install'}

" Other
Plugin 'Yggdroot/indentLine'

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
vnoremap <C-n> <Esc>:nohl<CR>
inoremap <C-n> <Esc>:nohl<CR>

" bind Ctrl + movement kets to move around the windows, instead of using Ctrl+w+movement
nnoremap <A-j> <C-W><C-J>
nnoremap <A-k> <C-W><C-K>
nnoremap <A-l> <C-W><C-L>
nnoremap <A-h> <C-W><C-H>

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
colorscheme palenight
hi Normal guibg=None

" Show line numbers and length
set rnu
set number
set nowrap

" C indentation
au BufNewFile,BufRead *.c,*.cpp
    \ set tabstop=4 |
    \ set shiftwidth=4 |
    \ set expandtab |

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
command! -nargs=* T split | terminal <args>
command! -nargs=* VT vsplit | terminal <args>
tnoremap <Esc> <C-\><C-n>
noremap <A-t> :vsplit +terminal<CR>
au TermOpen * setlocal nonumber norelativenumber

" Single-file coding stuff
autocmd filetype c nnoremap <F9> :w <bar> !gcc -Wall -Wextra -O2 % -o %:r -Wl,--stack,268435456<CR>
autocmd filetype c nnoremap <F10> :!./%:r<CR>

" PLUGINS CONFIGURATION =======================================================

" @1. Coc ---------------------------------------------------
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

nmap <leader>rn <Plug>(coc-rename)

" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

" @2. Lightline -------------------------------------------------
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

" @3. NERDTRee ----------------------------------------------------
let g:NERDTreeChDirMode=2
let g:NERDTreeIgnore=['\.rbc$', '\~$', '\.pyc$', '\.db$', '\.sqlite$', '__pycache__']
let g:NERDTreeSortOrder=['^__\.py$', '\/$', '*', '\.swp$', '\.bak$', '\~$']
let g:NERDTreeShowHidden = 1
let g:NERDTreeDirArrows = 1
let g:NERDTreeHijackNetrw = 1
let g:NERDTreeWinSize=40
let g:NERDTreeMapOpenInTab='\r'
set wildignore+=*/tmp/*,*.so,*.swp,*.zip,*.pyc,*.db,*.sqlite

autocmd StdinReadPre * let s:std_in=1
"autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in") | exe 'NERDTree' argv()[0] | wincmd p | ene | q | endif
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
nmap <A-e> :NERDTreeFocus<cr>R<C-W><C-P><CR>
map <C-e> :NERDTreeTabsToggle<CR>

" Nerd tree highlighting
let g:NERDTreeFileExtensionHighlightFullName = 1
let g:NERDTreeExactMatchHighlightFullName = 1
let g:NERDTreePatternMatchHightlightFullName = 1

" @4. Fzf.vim -----------------------------------------------
set wildmode=list:longest,list:full
set wildignore+=*.o,*.obj,.git,*.rbc,*.pyc,__pycache__
let $FZF_DEFAULT_COMMAND =  "find * -path '*/\.*' -prune -o -path 'node_modules/**' -prune -o -path 'target/**' -prune -o -path 'dist/**' -prune -o  -type f -print -o -type l -print 2> /dev/null"

" The Silver Searcher
if executable('ag')
  let $FZF_DEFAULT_COMMAND = 'ag --hidden --ignore-dir .git --ignore-dir node_modules -g ""'
  set grepprg=ag\ --nogroup\ --nocolor
endif

nnoremap <C-p> :Files<CR>
cnoremap <C-P> <C-R>=expand("%:p:h") . "/" <CR>
nnoremap <Leader>b :Buffers<CR>
nnoremap <Leader>h :History<CR>
nnoremap <Leader>t :BTags<CR>
nnoremap <Leader>T :Tags<CR>

" @5. Tags -------------------------------------------------
let g:gutentags_add_default_project_roots = 0
let g:gutentags_project_root = ['package.json', '.git']
let g:gutentags_cache_dir = expand('~/.cache/vim/ctags/')
let g:gutentags_generate_on_new = 1
let g:gutentags_generate_on_missing = 1
let g:gutentags_generate_on_write = 1
let g:gutentags_generate_on_empty_buffer = 0
let g:gutentags_ctags_extra_args = [
      \ '--tag-relative=yes',
      \ '--fields=+ailmnS',
      \ ]
let g:gutentags_ctags_exclude = [
      \ '*.git', '*.svg', '*.hg',
      \ '*/tests/*',
      \ 'build',
      \ 'dist',
      \ '*sites/*/files/*',
      \ 'bin',
      \ 'node_modules',
      \ 'bower_components',
      \ 'cache',
      \ 'compiled',
      \ 'docs',
      \ 'example',
      \ 'bundle',
      \ 'vendor',
      \ '*.md',
      \ '*-lock.json',
      \ '*.lock',
      \ '*bundle*.js',
      \ '*build*.js',
      \ '.*rc*',
      \ '*.json',
      \ '*.min.*',
      \ '*.map',
      \ '*.bak',
      \ '*.zip',
      \ '*.pyc',
      \ '*.class',
      \ '*.sln',
      \ '*.Master',
      \ '*.csproj',
      \ '*.tmp',
      \ '*.csproj.user',
      \ '*.cache',
      \ '*.pdb',
      \ 'tags*',
      \ 'cscope.*',
      \ '*.css',
      \ '*.less',
      \ '*.scss',
      \ '*.exe', '*.dll',
      \ '*.mp3', '*.ogg', '*.flac',
      \ '*.swp', '*.swo',
      \ '*.bmp', '*.gif', '*.ico', '*.jpg', '*.png',
      \ '*.rar', '*.zip', '*.tar', '*.tar.gz', '*.tar.xz', '*.tar.bz2',
      \ '*.pdf', '*.doc', '*.docx', '*.ppt', '*.pptx',
      \ ]

command! -nargs=0 GutentagsClearCache call system('rm ' . g:gutentags_cache_dir . '/*')

" @6. Ultisnips -------------------------------------------------
let g:UltiSnipsExpandTrigger = '<C-z>'
let g:UltiSnipsJumpForwardTrigger = '<C-z>'
let g:UltiSnipsJumpBackwardTrigger = '<C-b>'

" @7. VeBugger --------------------------------------------------


" @8. Vim-session
nnoremap <leader>so :OpenSession<Space>
nnoremap <leader>ss :SaveSession<Space>
nnoremap <leader>sd :DeleteSession<CR>
nnoremap <leader>sc :CloseSession<CR>

let g:session_directory = "~/.config/nvim/sessions"
let g:session_autosave = 'no'
let g:session_autoload = 'no'

" @0.1. Emmet ---------------------------------------------------
let g:user_emmet_install_global = 0
autocmd FileType html,htmldjango,css,jst EmmetInstall
let g:user_emmet_settings = webapi#json#decode(join(readfile(expand('~/.config/nvim/emmet_snippets.json')), "\n"))
let g:user_emmet_leader_key=','

" @0.2. Vim-javascript ------------------------------------------
let g:javascript_plugin_jsdoc = 1
let g:javascript_enable_domhtmlcss = 1

" @0.3. Markdown ------------------------------------------------
" Markdown-preview
let g:mkdp_browser = 'firefox'
let g:mkdp_auto_closer = 0

" @0.4. Indentline ----------------------------------------------
let g:indentLine_enabled = 1
" let g:indentLine_setColors = 0
let g:indentLine_color_term = 239
let g:indentLine_concealcursor = 0
let g:indentLine_char = '┆' 
let g:indentLine_faster = 1
set conceallevel=1
let g:indentLine_conceallevel = 1

" @0.0. Uncategorized -------------------------------------------
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

" Git-fugitive -----------------------------------------------
nmap <leader>gs :vertical Gstatus<cr>gg<C-n>
nmap <leader>gd :vertical Gdiff<CR>

" Polyglot ---------------------------------------------------
let g:polyglot_disabled = ['python']
let python_highlight_all = 1

