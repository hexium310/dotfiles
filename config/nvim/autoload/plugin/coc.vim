function! plugin#coc#set_maps() abort
  nnoremap <silent> K :call plugin#coc#show_documentation()<CR>
endfunction

function! plugin#coc#set_commands() abort
  command! -nargs=0 Rename :call CocAction('rename')
endfunction

function! plugin#coc#show_documentation() abort
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction
