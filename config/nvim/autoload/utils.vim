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

function! utils#run_yarn_start() abort
  if exists('g:yarn_start_job_id')
    return
  endif

  new
  let g:yarn_start_job_id = termopen('yarn start', { 'on_exit': function('s:OnExit') })
  file job: yarn start
  setlocal nobuflisted
  stopinsert
  quit
endfunction

function! utils#show_yarn_start() abort
  if !exists('g:yarn_start_job_id')
    return
  endif

  split job: yarn start
endfunction

function! utils#stop_yarn_start() abort
  if !exists('g:yarn_start_job_id')
    return
  endif

  call jobstop(g:yarn_start_job_id)
endfunction

function! s:OnExit(job_id, data, event)
  unlet g:yarn_start_job_id

  if a:data == 1
    split job: yarn start
    silent 0file
    return
  endif

  buffer job: yarn start
  startinsert
  call feedkeys("\<Cr>")
endfunction
