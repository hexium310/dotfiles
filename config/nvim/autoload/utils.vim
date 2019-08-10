function! utils#open_terminal() abort
  const terminal_buffers = filter(getbufinfo(), 'v:val.name =~ "^term://.*$"')

  if empty(terminal_buffers)
    split
    terminal

    return
  endif

  const latest_terminal_buffer = get(terminal_buffers, -1)
  const window_ids = win_findbuf(latest_terminal_buffer.bufnr)

  if empty(window_ids)
    split
    execute 'edit' latest_terminal_buffer.name
    startinsert

    return
  endif

  call win_gotoid(window_ids[0])
endfunction

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
