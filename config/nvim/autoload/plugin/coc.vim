function! plugin#coc#set_variables() abort
  let g:coc_enable_locationlist = 0
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
        \   'coc-emmet',
        \   'https://github.com/rodrigore/coc-tailwind-intellisense',
        \ ]
endfunction

function! plugin#coc#set_maps() abort
  nnoremap <silent> K :call plugin#coc#show_documentation()<Cr>
  inoremap <silent><expr> <C-x><C-n> coc#refresh()
  inoremap <silent> <Cr> <C-]><C-g>u<Cr><C-r>=coc#on_enter()<Cr>
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
  if index(['vim','help'], &filetype) >= 0
    silent! execute 'h '.expand('<cword>')
  else
    call CocActionAsync('doHover')
  endif
endfunction

function! plugin#coc#autocmd() abort
  augroup coc
    autocmd!
    autocmd User CocDiagnosticChange,CocGitStatusChange call lightline#update()
    autocmd User CocOpenFloat
          \ execute 'autocmd BufWinLeave <buffer=' . winbufnr(g:coc_last_float_win) . '> set backspace=' |
          \ call setwinvar(g:coc_last_float_win, '&backspace', 'indent,eol,start') |
          \ call setwinvar(g:coc_last_float_win, '&filetype', 'coc_float')
    autocmd User CocLocationsChange CocList --normal location
  augroup END
endfunction
