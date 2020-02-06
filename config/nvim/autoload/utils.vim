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

function! utils#fold_text(nums) abort
  let current_line_text = getline(v:foldstart)
  let line_numbers = printf('[ %5s ]', v:foldend - v:foldstart + 1)
  let unmodified = '[ Unmodified ]'
  let repeat_count = &columns - &foldcolumn - &numberwidth - (&signcolumn == 'yes' ? 2 : 0) - len(current_line_text) - len(line_numbers)

  if index(a:nums, v:foldstart) >= 0
    return current_line_text . repeat(' ', repeat_count) . line_numbers
  endif

  return current_line_text . repeat(' ', repeat_count - len(unmodified)) . unmodified . line_numbers
endfunction

function! utils#fold_place_without_gitgutter_sign() abort
  let b:gitgutter_sign_lnums = map(sign_getplaced(expand('%'), {'group':'gitgutter'})[0].signs, { _, val -> val.lnum })
  let max = max(b:gitgutter_sign_lnums)
  let min = min(b:gitgutter_sign_lnums)

  setlocal foldmethod=indent
  redraw
  setlocal foldmethod=manual

  if max == 0
    return
  endif

  execute(':0,' . min . '-1fold')
  execute(':' . max . '+1,$fold')
endfunction
