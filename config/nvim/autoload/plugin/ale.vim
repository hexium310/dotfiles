function! plugin#ale#set_variable() abort
  let g:ale_linters = {
        \  'typescript': ['eslint'],
        \  'javascript': ['eslint'],
        \}
  let g:ale_fixers = {
        \  'typescript': [
        \    { buffer, lines -> {
        \      'command': 'yarn eslint --fix --config .eslintrc.fix.json %t', 'read_temporary_file': 1
        \    } }
        \  ],
        \  'javascript': [
        \    { buffer, lines -> {
        \      'command': 'yarn eslint --fix --config .eslintrc.fix.json %t', 'read_temporary_file': 1
        \    } }
        \  ],
        \}
  let g:ale_lint_delay = 50
  let g:ale_echo_msg_format = '%severity% [%linter%] %s'
endfunction

function! plugin#ale#set_maps() abort
  nmap <silent> [a <Plug>(ale_previous_wrap)
  nmap <silent> ]a <Plug>(ale_next_wrap)
endfunction
