function! utils#open_terminal() abort
  let terminal_buffers = filter(getbufinfo(), 'v:val.name =~ "^term://.*$"')

  if empty(terminal_buffers)
    split
    terminal

    return
  endif

  let latest_terminal_buffer = get(terminal_buffers, -1)
  let window_ids = win_findbuf(latest_terminal_buffer.bufnr)

  if empty(window_ids)
    split
    execute 'edit' latest_terminal_buffer.name
    startinsert

    return
  endif

  call win_gotoid(window_ids[0])
endfunction
