function! utils#remove_multiple_empty_lines(target_filetypes) abort
  for filetype in split(&filetype, '\.')
    if index(a:target_filetypes, filetype) >= 0
      silent! keeppatterns %s/\v(\n\n)\n+/\1/
      return
    endif
  endfor
endfunction

function! utils#insert_newline_in_element_attributes() abort
  silent! keeppatterns s/\v%(\{)@1<!%( (\l)|(\>$))/\r\1\2/g
endfunction
