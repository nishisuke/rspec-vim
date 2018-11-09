scriptencoding utf-8

if !exists('g:loaded_railsgvim')
    finish
endif
let g:loaded_railsgvim = 1

let s:save_cpo = &cpo
set cpo&vim

""""""""""""""""""""
" begin my func

fun railsgvim#SetSpecClass()
  let l:path = expand('%')
  if match(l:path, 'app/') != 0
    return
  endif
  let l:path = strcharpart(l:path, 4)
  let l:list = matchlist(l:path, '\v([0-9a-z_]+)/([0-9a-z_/]+)\.rb')

  if l:list[1] == 'views'
    return 0
  elseif l:list[1] == 'models'
    let l:superclass = 'ApplicationRecord'
  elseif l:list[1] == 'controllers'
    let l:superclass = 'ApplicationController'
  else
    let l:superclass = ''
  endif

  let l:class = join(map(split(l:list[2], '/'), function('railsgvim#PascalCase')), '::')

  call setline('.', '# frozen_string_literal: true')
  if strchars(l:superclass) == 0
    call append(1, ['', 'class '.l:class, 'end'])
  else
    call append(1, ['', 'class '.l:class.' < '.l:superclass, 'end'])
  endif
endfun

func railsgvim#PascalCase(key, val)
  return join(map(split(a:val, '_'), function('railsgvim#FirstUpper')), '')
endfunc

func railsgvim#FirstUpper(key, val)
  return substitute(a:val, '^\l', '\u&', '')
endfunc

" end my func
""""""""""""""""""""

let &cpo = s:save_cpo
unlet s:save_cpo
