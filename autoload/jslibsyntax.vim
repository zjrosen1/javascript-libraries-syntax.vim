" Vim plugin file
" Language:    JS Lib syntax loader
" Maintainer:  othree <othree@gmail.com>
" Last Change: 2014/10/29
" Version:     0.3
" URL:         https://github.com/othree/javascript-libraries-syntax.vim

let s:libs = [
  \ 'jquery',
  \ 'underscore',
  \ 'backbone',
  \ 'prelude',
  \ 'angularjs',
  \ 'angularui',
  \ 'requirejs',
  \ 'sugar',
  \ 'jasmine',
  \ 'react'
  \ ]

let s:default_libs = [
  \ 'jquery',
  \ 'underscore',
  \ 'backbone',
  \ 'react'
  \ ]

let s:path = expand('<sfile>:p:h')

function! jslibsyntax#load()
  if !exists('g:used_javascript_libs') 
    let g:used_javascript_libs = join(s:default_libs, ',')
  endif

  let index = 0
  let loaded = 0
  while index < len(s:libs)
    let lib = s:libs[index]
    let use = g:used_javascript_libs =~ lib
    if exists('b:javascript_lib_use_'.lib)
      exec('let use = b:javascript_lib_use_'.lib)
    endif
    if use
      let fn = s:path.'/syntax/'.lib.'.'.&filetype.'.vim'
      if filereadable(fn)
        exe('source '.fnameescape(fn))
        let loaded = loaded + 1
      endif
    endif
    let index = index + 1
  endwhile
  let fn = s:path.'/syntax/postprocess.'.&filetype.'.vim'
  if loaded > 0 && filereadable(fn)
    exe('source '.fnameescape(fn))
  endif
endfunction

