function! plugin#ale#set_variable() abort
  let g:ale_linters = {
        \  'typescript': ['eslint'],
        \  'javascript': ['eslint'],
        \}
  let g:ale_disable_lsp = 1
  let g:ale_echo_msg_format = '%severity% [%linter%] %s'
  let g:ale_history_enabled = 0
  let g:ale_history_log_output = 0
  let g:ale_lint_on_filetype_changed = 0
  let g:ale_lint_on_insert_leave = 0
  let g:ale_lint_on_text_changed = 0
  let g:ale_rust_cargo_use_check = 0
  let g:ale_rust_cargo_use_clippy = 1
endfunction

function! plugin#ale#set_maps() abort
  nmap <silent> [a <Plug>(ale_previous_wrap)
  nmap <silent> ]a <Plug>(ale_next_wrap)
endfunction
