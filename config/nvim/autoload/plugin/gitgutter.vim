function! plugin#gitgutter#set_variables() abort
  let g:gitgutter_override_sign_column_highlight = 0
  let g:gitgutter_map_keys = 0
  let g:gitgutter_sign_added = '\ '
  let g:gitgutter_sign_modified = '\ '
  let g:gitgutter_sign_removed = '\ '
  let g:gitgutter_sign_removed_first_line = '\ '
  let g:gitgutter_sign_modified_removed = '\ '
endfunction

function! plugin#gitgutter#set_maps() abort
  nmap <silent> [g <Plug>GitGutterPrevHunk
  nmap <silent> ]g <Plug>GitGutterNextHunk
endfunction

function! plugin#gitgutter#define_sign_linenr_highlights() abort
  sign define GitGutterLineAdded numhl=GitGutterAddLineNr
  sign define GitGutterLineModified numhl=GitGutterChangeLineNr
  sign define GitGutterLineRemoved numhl=GitGutterDeleteLineNr
  sign define GitGutterLineRemovedFirstLine numhl=GitGutterDeleteLineNr
  sign define GitGutterLineRemovedAboveAndBelow numhl=GitGutterDeleteLineNr
  sign define GitGutterLineModifiedRemoved numhl=GitGutterChangeDeleteLineNr
endfunction
