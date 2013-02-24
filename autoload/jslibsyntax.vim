" Vim plugin file
" Language:    JS Lib syntax loader
" Maintainer:  othree <othree@gmail.com>
" Last Change: 2013/02/24
" Version:     0.3
" URL:         https://github.com/othree/javascript-libraries-syntax.vim

function! jslibsyntax#load(path)
  if exists('b:javascript_libraries_syntax')
    return
  endif
  let b:javascript_libraries_syntax = 1

  let s:libs = ['jquery', 'underscore', 'backbone', 'prelude', 'angularjs', 'requirejs']
  if !exists('g:used_javascript_libs') 
    let g:used_javascript_libs = join(s:libs, ',')
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
      let fn = a:path.'/autoload/syntax/'.lib.'.'.&filetype.'.vim'
      if filereadable(fn)
        exe('source '.fn)
        let loaded = loaded + 1
      endif
    endif
    let index = index + 1
  endwhile
  if loaded > 0
    exe('source '.a:path.'/autoload/syntax/postprocess.vim')
  endif
endfunction
