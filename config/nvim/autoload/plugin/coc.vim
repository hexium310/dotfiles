function! plugin#coc#set_variables() abort
  let g:coc_snippet_next = '<Tab>'
  let g:coc_snippet_prev = '<S-Tab>'
  let g:coc_status_error_sign = 'E: '
  let g:coc_status_warning_sign = 'W: '
  let g:coc_global_extensions = [
        \   'coc-snippets',
        \   'coc-highlight',
        \   'coc-emmet',
        \   'coc-tsserver',
        \   'coc-rls',
        \   'coc-json',
        \   'coc-yaml',
        \   'coc-vimlsp',
        \ ]
endfunction

function! plugin#coc#set_maps() abort
  nnoremap <silent> K :call plugin#coc#show_documentation()<CR>
  nmap <silent> [c <Plug>(coc-diagnostic-prev)
  nmap <silent> ]c <Plug>(coc-diagnostic-next)
  inoremap <silent><expr> <Tab>
        \ pumvisible() ? coc#_select_confirm() :
        \ coc#expandableOrJumpable() ? "\<C-r>=coc#rpc#request('doKeymap', ['snippets-expand-jump', ''])\<Cr>" :
        \ plugin#coc#check_backspace() ? "\<Tab>" :
        \ coc#refresh()
endfunction

function! plugin#coc#set_commands() abort
  command! -nargs=0 Rename :call CocAction('rename')
endfunction

function! plugin#coc#check_backspace() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1] =~# '\s'
endfunction

function! plugin#coc#show_documentation() abort
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction
