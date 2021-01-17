let g:buftabline_numbers = 2
let g:buftabline_indicators = 1

nmap <A-1> <Plug>BufTabLine.Go(1)
nmap <A-2> <Plug>BufTabLine.Go(2)
nmap <A-3> <Plug>BufTabLine.Go(3)
nmap <A-4> <Plug>BufTabLine.Go(4)
nmap <A-5> <Plug>BufTabLine.Go(5)
nmap <A-6> <Plug>BufTabLine.Go(6)
nmap <A-7> <Plug>BufTabLine.Go(7)
nmap <A-8> <Plug>BufTabLine.Go(8)
nmap <A-9> <Plug>BufTabLine.Go(9)
nmap <A-0> <Plug>BufTabLine.Go(-1)

hi! BufTabLineCurrent guibg=NONE guifg=#57c7ff
hi! BufTabLinePath guibg=NONE guifg=#eea040
hi! BufTabLineHidden guibg=NONE guifg=#3e4452
hi! BufTabLineActive guibg=NONE guifg=#3e4452
