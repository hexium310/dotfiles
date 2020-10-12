function! plugin#fugitive#set_maps() abort
  nnoremap <silent> <Space>gs :Gstatus<Cr>
  nnoremap <silent> <Space>gw :Gwrite<Cr>
  nnoremap <silent> <Space>gd :Gdiff<Cr>
endfunction
