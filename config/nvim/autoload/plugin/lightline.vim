function! plugin#lightline#set_variables() abort
  let g:lightline = {
        \  'colorscheme': 'onedark',
        \  'active': {
        \    'left': [
        \      ['mode', 'paste'],
        \      ['readonly', 'filename', 'modified', 'dir'],
        \      ['coc_status_error', 'coc_status_warning', 'coc_status_ok'],
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
        \    'coc_status_ok': 'plugin#lightline#coc_status_ok',
        \  },
        \  'component_expand': {
        \    'ale_checking': 'lightline#ale#checking',
        \    'ale_warnings': 'lightline#ale#warnings',
        \    'ale_errors': 'lightline#ale#errors',
        \    'ale_ok': 'lightline#ale#ok',
        \    'coc_status_error': 'plugin#lightline#coc_status_error',
        \    'coc_status_warning': 'plugin#lightline#coc_status_warning',
        \  },
        \  'component_type': {
        \    'ale_checking': 'left',
        \    'ale_warnings': 'warning',
        \    'ale_errors': 'error',
        \    'ok': 'left',
        \    'coc_status_error': 'error',
        \    'coc_status_warning': 'error',
        \  },
        \}
endfunction

function plugin#lightline#autocmd() abort
  augroup coc
    autocmd User CocStatusChange call lightline#update()
  augroup END
endfunction

function! plugin#lightline#readonly()
  return &readonly || &filetype == 'help' ? '👀' : ''
endfunction

function! plugin#lightline#coc_status_error() abort
  let error = coc#status()
  if stridx(error, 'E:') == 0
    return error
  endif

  return ''
endfunction

function! plugin#lightline#coc_status_warning() abort
  let error = coc#status()
  if stridx(error, 'W:') == 0
    return error
  endif

  return ''
endfunction

function! plugin#lightline#coc_status_ok() abort
  let error = coc#status()
  if stridx(error, 'E:') != 0 && stridx(error, 'W:') != 0
    return error
  endif

  return ''
endfunction
