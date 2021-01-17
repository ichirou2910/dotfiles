set showtabline=2                       " Always show tabs

" Initialize
set statusline=

function! GitUpdate()
	if isdirectory('.git')
		let b:git_commit = '[' . system("echo $(git status --porcelain=v2 -bz) | rev | cut -d '#' -f1 | rev | cut -d ' ' -f3- | awk '{print $1\" \" $2}' | tr -d '\n'") . ']' |
		let b:git_branch = system("git rev-parse --abbrev-ref HEAD 2>/dev/null | tr -d '\n'")
	endif
endfunction

augroup gitstatusline
    au!

    autocmd BufEnter,FocusGained,BufWritePost * call GitUpdate()
augroup end


" function! GitBranch()
" 	if isdirectory('.git')
" 		return system("git rev-parse --abbrev-ref HEAD 2>/dev/null | tr -d '\n'")
" 	else
" 		return ''
" 	endif
" endfunction

" function! GitCommits()
" 	if isdirectory('.git')
" 		" I have absolutely no idea how I came to this shiet
" 		return '[' . system("echo $(git status --porcelain=v2 -bz) | rev | cut -d '\#' -f1 | rev | cut -d ' ' -f3- | cut -d '?' -f1 | tr -d '\n' | sed 's/.$//'") . ']'
" 	else
" 		return ''
" 	endif
" endfunction

function! StatusLineGit()
	if isdirectory('.git')
		let [a,m,r] = GitGutterGetHunkSummary()
		return printf('+%d ~%d -%d (%s) %s', a, m, r, get(b:, "git_branch", ""), get(b:, "git_commit", ""))
	else
		return ''
	endif
endfunction

function! StatusLineFileType()
	let l:type= &filetype
	if l:type == 'coc-explorer'
		return ''
	else
		return '[' . l:type . ']'
	endif
endfunction

function! StatusLineFileFormat()
	let l:type= &filetype
	let l:format= &fileformat
	if l:type == 'coc-explorer'
		return ''
	else
		return l:format
	endif
endfunction

function! StatusLineCurLine()
	let l:type= &filetype
	let l:linenr= line('.')
	if l:type == 'coc-explorer'
		return ''
	else
		return ' '. l:linenr
	endif
endfunction

function! StatusLineMaxLine()
	let l:type= &filetype
	let l:maxlinenr= line('$')
	if l:type == 'coc-explorer'
		return ''
	else
		return '/'.l:maxlinenr.' '
	endif
endfunction

function! StatusLineCurCol()
	let l:type= &filetype
	let l:colnr= col('.')
	if l:type == 'coc-explorer'
		return ''
	else
		return colnr
	endif
endfunction

function! StatusLineCoc()
	let l:type = &filetype
	if l:type == 'coc-explorer'
		return 'CoC Explorer'
	else
		return ''
	endif
endfunction

function! StatusLinePart(part)
	let l:type = &filetype
	if l:type == 'coc-explorer'
		return ''
	else
		return a:part
	endif
endfunction

" Colorized NV
" set statusline+=%3*\ [N%*          
" set statusline+=%6*V]%*            
set statusline+=%1*\ %{StatusLineCoc()}%*
set statusline+=%3*%{StatusLinePart('\[N')}%*
set statusline+=%6*%{StatusLinePart('V\]')}%*

" Git status
" set statusline+=%7*\ %*
set statusline+=%7*\ %{StatusLinePart(StatusLineGit())}\ %*

" Modified flag
" set statusline+=%2*%m\ %*     

" CoC status
set statusline+=%5*%{StatusLinePart(coc#status())}%{StatusLinePart(get(b:,'coc_current_function',''))}%*

" File format
set statusline+=%4*%=%{StatusLineFileFormat()}\ %*       

" File type
set statusline+=%7*%{StatusLineFileType()}\ %*             

" Current line
set statusline+=%1*%5{StatusLineCurLine()}%*             	

" Max line
set statusline+=%2*%{StatusLineMaxLine()}%*              

" Current column
set statusline+=%1*%4{StatusLineCurCol()}\ %*            

hi User1 gui=bold guifg=#eea040 guibg=#0c2461
hi User2 gui=bold guifg=#dd3333 guibg=#0c2461
hi User3 gui=bold guifg=#57c7ff guibg=#0c2461
hi User4 gui=bold guifg=#eeee40 guibg=#0c2461
hi User5 gui=bold guifg=#ffffff guibg=#0c2461
hi User6 gui=bold guifg=#a0ee40 guibg=#0c2461
hi User7 gui=bold guifg=#ff6ac1 guibg=#0c2461
