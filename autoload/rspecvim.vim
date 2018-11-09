scriptencoding utf-8

if !exists('g:loaded_rspecvim')
    finish
endif
let g:loaded_rspecvim = 1

let s:save_cpo = &cpo
set cpo&vim

""""""""""""""""""""
" begin my func

fun rspecvim#SetSpecClass()
  let l:path = expand('%')
  if match(l:path, 'spec/') != 0
    return
  endif
  let l:path = strcharpart(l:path, 5)
  let l:list = matchlist(l:path, '\v([0-9a-z_]+)/([0-9a-z_/]+)\.rb')

  let l:class = join(map(split(l:list[2], '/'), function('rspecvim#PascalCase')), '::')

  call setline('.', '# frozen_string_literal: true')
  call append(1, ['', 'class '.l:class, 'end'])
endfun

func rspecvim#PascalCase(key, val)
  return join(map(split(a:val, '_'), function('rspecvim#FirstUpper')), '')
endfunc

func rspecvim#FirstUpper(key, val)
  return substitute(a:val, '^\l', '\u&', '')
endfunc

" end my func
""""""""""""""""""""

let &cpo = s:save_cpo
unlet s:save_cpo
