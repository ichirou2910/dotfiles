let g:wintabs_display ="statusline"

let g:wintabs_ui_buffer_icon = 1
let g:wintabs_ui_buffer_name_format = '%t'

" let g:wintabs_ui_arrow_left = ""
" let g:wintabs_ui_arrow_right = ""
" let g:wintabs_ui_sep_buffer_transition= ""
" let g:wintabs_ui_sep_buffer = ""

" 181a1f, 1f2335, 1b1f27

hi! WintabsEmpty guifg=NONE guibg=None
hi! WintabsActive gui=bold guifg=#ffffff guibg=None
hi! WintabsInactive guifg=#6f7379 guibg=None
hi! WintabsActiveIcon guibg=None

hi! link WintabsEmptyNC WintabsEmpty
hi! WintabsActiveNC guifg=#ffffff guibg=None
hi! link WintabsInactiveNC WintabsInactive

" hi! WintabsEmptyNC guifg=NONE guibg=#191c29
" hi! WintabsActiveNC guifg=#6f7379 guibg=#383b42
" hi! WintabsInactiveNC guifg=#4d4d4d guibg=#191c29
hi! WintabsActiveIconNC guibg=None

" hi! WintabsEmptyNC guifg=NONE guibg=#191c29
" hi! WintabsActiveNC guifg=#6f7379 guibg=#2c2f34
" hi! WintabsInactiveNC guifg=#4d4d4d guibg=#191c29
" hi! WintabsActiveIconNC guibg=#2c2f34
"
hi! link WintabsArrow WintabsInactive
