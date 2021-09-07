function! plugin#gitgutter#set_variables() abort
  let g:gitgutter_override_sign_column_highlight = 0
  let g:gitgutter_preview_win_floating = 1
  let g:gitgutter_map_keys = 0
  let g:gitgutter_highlight_linenrs = 1
  let g:gitgutter_sign_added = '\ '
  let g:gitgutter_sign_modified = '\ '
  let g:gitgutter_sign_removed = '\ '
  let g:gitgutter_sign_removed_first_line = '\ '
  let g:gitgutter_sign_removed_above_and_below = '\ '
  let g:gitgutter_sign_modified_removed = '\ '
endfunction

function! plugin#gitgutter#set_maps() abort
  nmap <silent> <Space>h <Plug>(GitGutterPreviewHunk)
  nmap <silent> [g <Plug>(GitGutterPrevHunk)
  nmap <silent> ]g <Plug>(GitGutterNextHunk)
  omap ih <Plug>(GitGutterTextObjectInnerPending)
  omap ah <Plug>(GitGutterTextObjectOuterPending)
  xmap ih <Plug>(GitGutterTextObjectInnerVisual)
  xmap ah <Plug>(GitGutterTextObjectOuterVisual)
endfunction

function! plugin#gitgutter#set_autocmd() abort
  augroup gitgutter_config
    autocmd!
    autocmd OptionSet modified if
          \ bufwinnr('gitgutter://hunk-preview') > 0 |
          \   call nvim_win_set_config(win_getid(bufwinnr('gitgutter://hunk-preview')), { 'border': 'double' }) |
          \ end
  augroup END
endfunction
