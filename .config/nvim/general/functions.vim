" Random Useful Functions
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

" Turn spellcheck on for markdown files
" augroup auto_spellcheck
"   autocmd BufNewFile,BufRead *.md setlocal spell
" augroup END

augroup IBusHandler
  autocmd CmdLineEnter [/?] call IBusOn()
  autocmd CmdLineLeave [/?] call IBusOff()
  autocmd InsertEnter * call IBusOn()
  autocmd InsertLeave * call IBusOff()
augroup END
call IBusOff()

nnoremap <f10> :echo "hi<" . synIDattr(synID(line("."),col("."),1),"name") . '> trans<'
\ . synIDattr(synID(line("."),col("."),0),"name") . "> lo<"
\ . synIDattr(synIDtrans(synID(line("."),col("."),1)),"name") . ">"<cr>
