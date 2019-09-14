function! plugin#coc#set_variables() abort
  let g:coc_status_error_sign = 'E: '
  let g:coc_status_warning_sign = 'W: '
  let g:coc_status_info_sign = 'I: '
  let g:coc_global_extensions = [
        \   'coc-snippets',
        \   'coc-highlight',
        \   'coc-tsserver',
        \   'coc-rls',
        \   'coc-json',
        \   'coc-yaml',
        \   'coc-vimlsp',
        \   'coc-git',
        \   'coc-rust-analyzer',
        \ ]
endfunction

function! plugin#coc#set_maps() abort
  nnoremap <silent> K :call plugin#coc#show_documentation()<CR>
  nmap <silent> [c <Plug>(coc-diagnostic-prev)
  nmap <silent> ]c <Plug>(coc-diagnostic-next)
  nmap <silent> <Space>h <Plug>(coc-git-chunkinfo)
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
  augroup END
endfunction
