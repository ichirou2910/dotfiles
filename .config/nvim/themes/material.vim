if (has('termguicolors'))
  set termguicolors
endif

let g:material_terminal_italics = 1
let g:material_theme_style = 'darker'
colorscheme material

if exists('+termguicolors')
	let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
	let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
	set termguicolors
	hi! LineNr ctermbg=NONE guibg=NONE
	hi! Normal ctermbg=None guibg=None
	hi! NonText ctermbg=None guibg=None
	" hi! VertSplit ctermbg=NONE ctermfg=68 guibg=#00afff guifg=#000000
	hi! Comment cterm=italic ctermbg=NONE guibg=NONE
	hi! LineNr guibg=NONE
	hi! CursorLineNr ctermbg=236 ctermfg=NONE guibg=#303030
	hi! CursorLine ctermbg=236 ctermfg=NONE guibg=#303030
	hi! SignColumn ctermbg=NONE guibg=NONE
	hi! Folded ctermbg=NONE guibg=NONE
	hi! EndOfBuffer ctermbg=NONE ctermfg=NONE guibg=NONE guifg=#080808
	hi! WildMenu ctermfg=226 ctermbg=0 guifg=#ffff00 guibg=#000000
	hi! GitGutterAdd ctermbg=NONE guibg=NONE
	hi! GitGutterChange ctermbg=NONE guibg=NONE
	hi! GitGutterDelete ctermbg=NONE guibg=NONE
	hi! GitGutterChangeDelete ctermbg=NONE guibg=NONE
endif

