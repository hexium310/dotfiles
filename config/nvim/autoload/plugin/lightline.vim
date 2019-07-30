function! plugin#lightline#set_variables() abort
  let g:lightline = {
        \  'colorscheme': 'onedark',
        \  'active': {
        \    'left': [
        \      ['mode', 'paste'],
        \      ['readonly', 'filename', 'modified', 'dir', 'cocstatus'],
        \      ['sign'],
        \      ['anzu'],
        \    ],
        \    'right': [
        \      ['lineinfo', 'rows'],
        \      ['fileencoding', 'filetype'],
        \      ['ale_checking', 'ale_errors', 'ale_warnings', 'ale_ok'],
        \    ],
        \  },
        \  'tabline': {
        \    'right': [],
        \  },
        \  'component': {
        \    'dir': '%.35(%{expand("%:h:s?\\S$?\\0/?")}%)',
        \    'rows': '%LL',
        \  },
        \  'component_function': {
        \    'readonly': 'plugin#lightlinereadonly',
        \    'anzu': 'anzu#search_status',
        \    'cocstatus': 'coc#status',
        \  },
        \  'component_expand': {
        \    'ale_checking': 'lightline#ale#checking',
        \    'ale_warnings': 'lightline#ale#warnings',
        \    'ale_errors': 'lightline#ale#errors',
        \    'ale_ok': 'lightline#ale#ok',
        \  },
        \  'component_type': {
        \    'ale_checking': 'left',
        \    'ale_warnings': 'warning',
        \    'ale_errors': 'error',
        \    'ok': 'left',
        \  },
        \}
endfunction

function! plugin#lightline#readonly()
  return &readonly || &filetype == 'help' ? '👀' : ''
endfunction
