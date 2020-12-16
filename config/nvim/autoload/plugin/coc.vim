function! plugin#coc#set_variables() abort
  let g:coc_status_error_sign = 'E: '
  let g:coc_status_warning_sign = 'W: '
  let g:coc_status_info_sign = 'I: '
  let g:coc_global_extensions = [
        \   'coc-snippets',
        \   'coc-tsserver',
        \   'coc-json',
        \   'coc-yaml',
        \   'coc-vimlsp',
        \   'coc-git',
        \   'coc-rust-analyzer',
        \   'coc-pairs',
        \   'coc-emmet',
        \   'coc-tailwindcss',
        \ ]
endfunction

function! plugin#coc#set_maps() abort
  nnoremap <silent> K :call plugin#coc#show_documentation()<Cr>
  inoremap <silent><expr> <C-x><C-n> coc#refresh()
  inoremap <silent> <Cr> <C-g>u<Cr><C-r>=coc#on_enter()<Cr>
  nmap <silent> [c <Plug>(coc-diagnostic-prev)
  nmap <silent> ]c <Plug>(coc-diagnostic-next)
  nmap <silent> <Space>h <Plug>(coc-git-chunkinfo)
  nmap <silent> gf <Plug>(coc-definition)
  nnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  nnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
  inoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"
  inoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"
  vnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  vnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
endfunction

function! plugin#coc#set_commands() abort
  command! -nargs=0 Rename call CocActionAsync('rename')
  command! -nargs=0 RenameFile call CocActionAsync('runCommand', 'workspace.renameCurrentFile')
endfunction

function! plugin#coc#show_documentation() abort
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocActionAsync('doHover')
  endif
endfunction

function! plugin#coc#autocmd() abort
  augroup coc
    autocmd!
    autocmd CursorHoldI * silent call CocActionAsync('doHover')
    autocmd User CocDiagnosticChange,CocGitStatusChange call lightline#update()
  augroup END
endfunction
