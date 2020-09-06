" LIST OF CONFIGURED EXTENSIONS ==============================================
" Quick jump: @ + index
" 1. Coc.nvim
" 2. Airline
" 3. NERDTRee
" 4. Fzf-vim
" 5. Tags
" 6. Vim-session
" --------
" 0.1 Emmet (HTML)
" 0.2 vim-javascript (JS)
" 0.3 Markdown (MD)
" 0.0 Uncategorized

set runtimepath^=~/.vim runtimepath+=~/.vim/after
let &packpath = &runtimepath

" Vundle
set nocompatible

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin('~/.vim/plugged/vundle')

" PLUGINS LIST ===============================================================
Plugin 'VundleVim/Vundle.vim'

" Snippets
Plugin 'honza/vim-snippets'

" Visual theme
Plugin 'drewtempelmeyer/palenight.vim'
Plugin 'mhartington/oceanic-next'

" Visual status line
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'

" File handlers
Plugin 'preservim/nerdtree' | " file viewer
	Plugin 'Xuyuanp/nerdtree-git-plugin' |
	Plugin 'ryanoasis/vim-devicons'
Plugin 'jistr/vim-nerdtree-tabs' " make nerd tree feel like a panel
Plugin 'tiagofumo/vim-nerdtree-syntax-highlight' " Syntax highlighting for nerd tree

Plugin 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plugin 'junegunn/fzf.vim'

" SSG LORD TPOPE!!!!
Plugin 'tpope/vim-eunuch'
Plugin 'tpope/vim-fugitive'
Plugin 'tpope/vim-surround' " Handle pairs
Plugin 'tpope/vim-repeat' " Enhance dot commands
Plugin 'tpope/vim-commentary' " Code comments

" Git
Plugin 'junegunn/gv.vim'

" Tags
Plugin 'majutsushi/tagbar'

" Language support
Plugin 'neoclide/coc.nvim', {'branch': 'release'}

" Code formatter
Plugin 'google/vim-maktaba'
Plugin 'google/vim-codefmt'
Plugin 'google/vim-glaive'

" Debugger
Plugin 'Shougo/vimproc.vim'
Plugin 'idanarye/vim-vebugger'

" Vim-Session
Plugin 'xolox/vim-misc'
Plugin 'xolox/vim-session'

" Tmux
Plugin 'christoomey/vim-tmux-navigator'

" Python
Plugin 'vim-scripts/indentpython.vim' " Python indentation

" C, C++
Plugin 'vim-scripts/c.vim', {'for': ['c', 'cpp']}
Plugin 'octol/vim-cpp-enhanced-highlight'

" HTML
Plugin 'mattn/webapi-vim'
Plugin 'mattn/emmet-vim'
Plugin 'tpope/vim-haml'
Plugin 'hail2u/vim-css3-syntax'
Plugin 'gko/vim-coloresque'
Plugin 'tweekmonster/django-plus.vim' " Syntax highlighting for django html

" Javascript
Plugin 'othree/yajs.vim'
Plugin 'othree/javascript-libraries-syntax.vim'

" Dart
Plugin 'dart-lang/dart-vim-plugin'

" PHP
Plugin 'arnaud-lb/vim-php-namespace'

" Databases
Plugin 'tpope/vim-dadbod'
Plugin 'kristijanhusak/vim-dadbod-ui'

" Easy good-looking code
Plugin 'sheerun/vim-polyglot' " Support multiple languages
Plugin 'jiangmiao/auto-pairs' " Auto close
Plugin 'nvie/vim-flake8' " Python PEP8 antidote

" Note taking
Plugin 'iamcco/markdown-preview.nvim', {'do' : 'cd app && yarn install'}

" Other
Plugin 'Yggdroot/indentLine'
Plugin 'raghur/vim-ghost', {'do': ':GhostInstall'}
Plugin 'moll/vim-bbye'

call vundle#end()
call glaive#Install()

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

" Colorscheme
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

au FileType vim
	\ set tabstop=2 |
	\ set softtabstop=2 |
	\ set shiftwidth=2 |
	\ set noexpandtab |

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
au BufNewFile,BufRead *.html,*.css,*.js,*.json,*.dart
	\ set tabstop=2 |
	\ set shiftwidth=2 |
	\ set expandtab |

au FileType dart nmap <F5> :CocCommand flutter.run<CR>
au FileType dart nmap <F6> :CocList --input=flutter commands<CR>

" Unfold all when open a file
au BufWinEnter * normal zR

" Terminal
if has("nvim")
	au TermOpen * tnoremap <buffer> <Esc> <C-\><C-n>
	au FileType fzf tunmap <buffer> <Esc>
endif

" Single-file coding stuff
" autocmd filetype c nnoremap <F9> :w <bar> !gcc -Wall -Wextra -O2 % -o %:r -Wl,--stack,268435456<CR>
" autocmd filetype c nnoremap <F10> :!alacritty -e ./%:r<CR>
" autocmd filetype cpp nnoremap <F9> :w <bar> !g++ -std=c++14 % -o %:r -Wl,--stack,268435456<CR>
" autocmd filetype cpp nnoremap <F10> :!alacritty -e ./%:r<CR>

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

nmap <leader>ca <Plug>(coc-codeaction)
nmap <leader>qf <Plug>(coc-fix-current)

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

command! -nargs=0 Format :call CocAction('format')
command! -nargs=? Fold :call CocAction('fold', <f-args>)
"
" Tab completion
inoremap <silent><expr> <Tab>
	\ pumvisible() ? coc#_select_confirm() :
	\ coc#expandableOrJumpable() ? "\<C-r>=coc#rpc#request('doKeymap', ['snippets-expand-jump',''])\<CR>" :
	\ <SID>check_back_space() ? "\<TAB>" :
	\ coc#refresh()

inoremap <expr> <C-j> pumvisible() ? "\<C-N>" : "\<C-j>"
inoremap <expr> <C-k> pumvisible() ? "\<C-P>" : "\<C-k>"

function! s:check_back_space() abort
    let col = col('.') - 1
    return !col || getline('.')[col - 1] =~# '\s'
endfunction

let g:coc_snippet_next = '<C-l>'
let g:coc_snippet_prev = '<C-h>'

" @2. Airline ---------------------------------------------------
set noshowmode
let g:airline_theme = 'behelit'
let g:airline_powerline_fonts = 1
let g:airline_skip_empty_sections = 1

let g:airline#extensions#fzf#enabled = 1

let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#tab_nr_type = 1
let g:airline#extensions#tabline#formatter = 'unique_tail_improved'
let g:airline#extensions#tabline#left_sep = ''
let g:airline#extensions#tabline#left_alt_sep = '|'

let g:airline#extensions#coc#enabled = 1
let airline#extensions#coc#error_symbol = 'E:'
let airline#extensions#coc#warning_symbol = 'W:'
let airline#extensions#coc#stl_format_err = '%E{[%e(#%fe)]}'
let airline#extensions#coc#stl_format_warn = '%W{[%w(#%fw)]}'

let g:airline#extensions#hunks#enabled = 1
let g:airline#extensions#hunks#non_zero_only = 0
let g:airline#extensions#hunks#hunk_symbols = ['+', '~', '-']
let g:airline#extensions#hunks#coc_git = 1

if !exists('g:airline_symbols')
  let g:airline_symbols = {}
endif

let g:airline_left_sep = ''
let g:airline_left_alt_sep = '|'
let g:airline_right_sep = ''
let g:airline_right_alt_sep = '|'

let g:airline_section_error= ''
let g:airline_section_warning= ''

let g:airline#extensions#coc#enabled = 1
let g:airline#extensions#fzf#enabled = 1

" @3. NERDTRee ----------------------------------------------------
let g:NERDTreeChDirMode=2
let g:NERDTreeIgnore=['\.rbc$', '\~$', '\.pyc$', '\.db$', '\.sqlite$', '__pycache__', '^node_modules']
let g:NERDTreeSortOrder=['^__\.py$', '\/$', '*', '\.swp$', '\.bak$', '\~$']
let g:NERDTreeShowHidden = 1
let g:NERDTreeDirArrows = 1
let g:NERDTreeHijackNetrw = 0
let g:NERDTreeWinSize=40
let g:NERDTreeMapOpenInTab='\r'
" let g:NERDTreeCustomOpenArgs = {'file':{'where':'t'}}
set wildignore+=*/tmp/*,*.so,*.swp,*.zip,*.pyc,*.db,*.sqlite

autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in") | exe 'NERDTree' argv()[0] | wincmd p | ene | q | endif
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
" Refresh NERDTree on write event ONLY when NERDTree is opened
autocmd BufWritePost * if exists("t:NERDTreeBufName") && bufwinnr(t:NERDTreeBufName) != -1 | NERDTreeFocus | execute 'normal R' | wincmd p | endif
nmap <A-e> :NERDTreeFocus<cr>R<C-W><C-P><CR>
map <C-e> :NERDTreeTabsToggle<CR>

" Prevent opening files on NERDTree window
autocmd BufEnter * if bufname('#') =~# "^NERD_tree_" && winnr('$') > 1 | b# | endif

" Nerd tree highlighting
let g:NERDTreeFileExtensionHighlightFullName = 1
let g:NERDTreeExactMatchHighlightFullName = 1
let g:NERDTreePatternMatchHightlightFullName = 1

" Check if NERDTree is open or active
function! IsNERDTreeOpen()
  return exists("t:NERDTreeBufName") && (bufwinnr(t:NERDTreeBufName) != -1)
endfunction

" Call NERDTreeFind iff NERDTree is active, current window contains a modifiable
" file, and we're not in vimdiff
function! SyncTree()
  if &modifiable && IsNERDTreeOpen() && strlen(expand('%')) > 0 && !&diff
    NERDTreeFind
    wincmd p
  endif
endfunction

" Highlight currently open buffer in NERDTree
autocmd BufRead * call SyncTree()

" @4. Fzf.vim -----------------------------------------------
set wildmode=list:longest,list:full
set wildignore+=*.o,*.obj,.git,*.rbc,*.pyc,__pycache__
let $FZF_DEFAULT_COMMAND =  "find * -path '*/\.*' -prune -o -path 'node_modules/**' -prune -o -path 'target/**' -prune -o -path 'dist/**' -prune -o  -type f -print -o -type l -print 2> /dev/null"

" The Silver Searcher
if executable('ag')
  let $FZF_DEFAULT_COMMAND = 'ag --hidden --ignore-dir .git --ignore-dir node_modules -g ""'
  set grepprg=ag\ --nogroup\ --nocolor
endif

" ripgrep
if executable('rg')
  let $FZF_DEFAULT_COMMAND = 'rg --files --hidden --follow --glob "!.git/*"'
  set grepprg=rg\ --vimgrep
  command! -bang -nargs=* Find call fzf#vim#grep('rg --column --line-number --no-heading --fixed-strings --ignore-case --hidden --follow --glob "!.git/*" --color "always" '.shellescape(<q-args>).'| tr -d "\017"', 1, <bang>0)
endif

nnoremap <C-p> :Files<CR>
cnoremap <C-P> <C-R>=expand("%:p:h") . "/" <CR>
nnoremap <Leader>b :Buffers<CR>
nnoremap <Leader>h :History<CR>
nnoremap <Leader>t :BTags<CR>
nnoremap <Leader>T :Tags<CR>
nnoremap <silent> <Leader>f :Rg<CR>

" @5. Tags -------------------------------------------------
nmap <F8> :TagbarToggle<CR>
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

" @6. Vim-session
nnoremap <leader>so :OpenSession<Space>
nnoremap <leader>ss :SaveSession<Space>
nnoremap <leader>sd :DeleteSession<CR>
nnoremap <leader>sc :CloseSession<CR>

let g:session_directory = "~/.config/nvim/sessions"
let g:session_autosave = 'no'
let g:session_autoload = 'no'

" @0.1. Emmet ---------------------------------------------------
let g:user_emmet_install_global = 0
autocmd FileType html,php,htmldjango,css,jst,javascript,javascriptreact EmmetInstall
let g:user_emmet_settings = webapi#json#decode(join(readfile(expand('~/.config/nvim/emmet_snippets.json')), "\n"))
let g:user_emmet_leader_key=','

" @0.2. Vim-javascript ------------------------------------------
let g:used_javascript_libs = 'jquery,react,vue'

" @0.3. Markdown ------------------------------------------------
" Markdown-preview
let g:mkdp_browser = 'firefox'
let g:mkdp_auto_closer = 0

" @0.4. Indentline ----------------------------------------------
let g:indentLine_enabled = 1
let g:indentLine_color_term = 239
let g:indentLine_concealcursor = 0
let g:indentLine_char = '┆'
let g:indentLine_faster = 1
set conceallevel=1
let g:indentLine_conceallevel = 1

" @0.0. Uncategorized -------------------------------------------
" Git-fugitive -----------------------------------------------
nmap <leader>gs :vertical Gstatus<cr>gg<C-n>
nmap <leader>gd :vertical Gdiff<CR>
nmap <leader>gm :Gcommit<CR>

" Polyglot ---------------------------------------------------
let g:polyglot_disabled = ['python', 'javascript']
let python_highlight_all = 1

" Ibus settings
function! IBusOff()
	" Save current engine
	let g:ibus_prev_engine = system('ibus engine')
	" Change to English engine
	execute 'silent !ibus engine xkb:us::eng'
endfunction
function! IBusOn()
	let l:current_engine = system('ibus engine')
	" If engine was changed in Normal mode, use it instead
	if l:current_engine !~? 'xkb:us::eng'
			let g:ibus_prev_engine = l:current_engine
	endif
	" Restore engine
	execute 'silent !' . 'ibus engine ' . g:ibus_prev_engine
endfunction
augroup IBusHandler
	autocmd CmdLineEnter [/?] call IBusOn()
	autocmd CmdLineLeave [/?] call IBusOff()
	autocmd InsertEnter * call IBusOn()
	autocmd InsertLeave * call IBusOff()
augroup END
call IBusOff()

" Vim Devicons
let s:brown = "905532"
let s:aqua =  "3AFFDB"
let s:blue = "689FB6"
let s:darkBlue = "44788E"
let s:purple = "834F79"
let s:lightPurple = "834F79"
let s:red = "AE403F"
let s:beige = "F5C06F"
let s:yellow = "F09F17"
let s:orange = "D4843E"
let s:darkOrange = "F16529"
let s:pink = "CB6F6F"
let s:salmon = "EE6E73"
let s:green = "8FAA54"
let s:lightGreen = "31B53E"
let s:white = "FFFFFF"
let s:rspec_red = 'FE405F'
let s:git_orange = 'F54D27'

let g:webdevicons_conceal_nerdtree_brackets = 0
let g:WebDevIconsNerdTreeAfterGlyphPadding = ' '
let g:WebDevIconsUnicodeDecorateFolderNodes = 1
let g:DevIconsEnableFoldersOpenClose = 1

let g:WebDevIconsUnicodeDecorateFileNodesExactSymbols = {} " needed
let g:WebDevIconsUnicodeDecorateFileNodesExactSymbols['.gitignore'] = ''
let g:WebDevIconsUnicodeDecorateFileNodesExactSymbols['.gitconfig'] = ''
let g:WebDevIconsUnicodeDecorateFileNodesExactSymbols['.gitattributes'] = ''

let g:WebDevIconsUnicodeDecorateFileNodesExtensionSymbols = {} " needed
let g:WebDevIconsUnicodeDecorateFileNodesExtensionSymbols['js'] = ''
let g:WebDevIconsUnicodeDecorateFileNodesExtensionSymbols['css'] = ''
let g:WebDevIconsUnicodeDecorateFileNodesExtensionSymbols['html'] = ''
let g:WebDevIconsUnicodeDecorateFileNodesExtensionSymbols['json'] = ''
let g:WebDevIconsUnicodeDecorateFileNodesExtensionSymbols['md'] = ''

let g:WebDevIconsDefaultFolderSymbolColor = s:green

if exists('g:loaded_webdevicons')
	call webdevicons#refresh()
endif
" Vim-nerdtree-syntax-highlighting
let g:NERDTreeFileExtensionHighlightFullName = 0
let g:NERDTreeExactMatchHighlightFullName = 0
let g:NERDTreePatternMatchHighlightFullName = 0

let g:NERDTreeExactMatchHighlightColor = {} " this line is needed to avoid error
let g:NERDTreeExactMatchHighlightColor['.gitignore'] = s:git_orange
let g:NERDTreeExactMatchHighlightColor['.gitconfig'] = s:git_orange
let g:NERDTreeExactMatchHighlightColor['.gitattributes'] = s:git_orange

" NERDTree Git Plugin
let g:NERDTreeGitStatusIndicatorMapCustom = {
	\ 'Modified'  :'!',
	\ 'Staged'    :'+',
	\ 'Untracked' :'?',
	\ 'Renamed'   :'»',
	\ 'Unmerged'  :'═',
	\ 'Deleted'   :'✕',
	\ 'Dirty'     :'X',
	\ 'Ignored'   :'/',
	\ 'Clean'     :'✓',
	\ 'Unknown'   :'?',
	\ }

" Vim Bbye
nmap <leader>q :Bdelete<CR>

" C.vim
let g:C_Ctrl_j = 'off'

" vim-codefmt
augroup autoformat_settings
  autocmd FileType bzl AutoFormatBuffer buildifier
  autocmd FileType c,cpp,proto,arduino AutoFormatBuffer clang-format
  autocmd FileType dart AutoFormatBuffer dartfmt
  autocmd FileType go AutoFormatBuffer gofmt
  autocmd FileType gn AutoFormatBuffer gn
  " autocmd FileType html,css,sass,scss,less,json AutoFormatBuffer js-beautify
  autocmd FileType java AutoFormatBuffer google-java-format
  autocmd FileType python AutoFormatBuffer yapf
  " Alternative: autocmd FileType python AutoFormatBuffer autopep8
  autocmd FileType rust AutoFormatBuffer rustfmt
  autocmd FileType vue AutoFormatBuffer prettier
augroup END

" vim c++ highlight
let g:cpp_class_scope_highlight = 1
let g:cpp_member_variable_highlight = 1
let g:cpp_class_decl_highlight = 1
let g:cpp_posix_standard = 1
let g:cpp_experimental_template_highlight = 1
let g:cpp_concepts_highlight = 1

" vim-dadbod-ui
let g:db_ui_execute_on_save = 0
" let g:db_ui_tmp_query_location = '~/dbui'
let g:db_ui_debug = 1
