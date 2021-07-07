function! plugin#fugitive#set_maps() abort
  nnoremap <silent> <C-g> :call <SID>ToggleStatusWindow()<Cr>
  nnoremap <silent> <Space>gw :Gwrite<Cr>
  nnoremap <silent> <Space>gd :Gdiff<Cr>
endfunction

function! s:ToggleStatusWindow() abort
  const status_window = filter(getwininfo(), { _, v -> has_key(v.variables, 'fugitive_status') })

  if empty(status_window)
    Git
    return
  endif

  call win_execute(status_window[0].winid, 'close')
endfunction
