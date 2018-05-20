scriptencoding utf-8
"/**
" * @file
" * @author
" * @version
" */
if exists("g:loaded_qargs")
  finish
endif
let g:loaded_qargs = 1

let s:save_cpo = &cpo
set cpo&vim

" command! -nargs=0 -bar Qargs execute 'args' QuickfixFilenames()
command! -nargs=0 -bar Qargs call s:QuickfixFilenames()
function! s:QuickfixFilenames()
  " Building a hash ensures we get each buffer only once
  let current_buffer = bufnr('%')
  let buffer_numbers = {}
  for quickfix_item in getqflist()
    let bufnr = quickfix_item['bufnr']
    " Lines without files will appear as bufnr=0
    if bufnr > 0
      let buffer_numbers[bufnr] = bufname(bufnr)
    endif
  endfor
  " return join(map(values(buffer_numbers), 'fnameescape(v:val)'))
  execute 'args ' . join(map(values(buffer_numbers), 'fnameescape(v:val)'))

  "execute 'normal! <C-o>'
  if bufexists(current_buffer)
      execute 'b ' . current_buffer
  else
      "What is location-list. I only use quickfix!
      execute 'q | cw'
  endif

  return
endfunction

let &cpo = s:save_cpo
unlet s:save_cpo
