scriptencoding utf-8

if exists('g:loaded_railsgvim')
    finish
endif

let g:loaded_railsgvim = 1

let s:save_cpo = &cpo
set cpo&vim

""""""""""""""""""""
" begin my code
"
augroup railsgvim
	autocmd!
	autocmd BufNewFile *.rb call railsgvim#SetRailsClass()
augroup END

" end my code
""""""""""""""""""""

let &cpo = s:save_cpo
unlet s:save_cpo
