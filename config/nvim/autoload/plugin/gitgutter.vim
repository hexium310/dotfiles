function! plugin#gitgutter#set_variables() abort
  let g:gitgutter_override_sign_column_highlight = 0
  let g:gitgutter_map_keys = 0
  let g:gitgutter_highlight_linenrs = 1
  let g:gitgutter_sign_added = '\ '
  let g:gitgutter_sign_modified = '\ '
  let g:gitgutter_sign_removed = '\ '
  let g:gitgutter_sign_removed_first_line = '\ '
  let g:gitgutter_sign_modified_removed = '\ '
  let g:gitgutter_max_signs = 1000
endfunction

function! plugin#gitgutter#set_maps() abort
  nmap <silent> [g <Plug>(GitGutterPrevHunk)
  nmap <silent> ]g <Plug>(GitGutterNextHunk)
  omap ih <Plug>(GitGutterTextObjectInnerPending)
  omap ah <Plug>(GitGutterTextObjectOuterPending)
  xmap ih <Plug>(GitGutterTextObjectInnerVisual)
  xmap ah <Plug>(GitGutterTextObjectOuterVisual)
endfunction
