function! plugin#lightline#set_variables() abort
  let g:lightline = {
        \  'colorscheme': 'onedark',
        \  'active': {
        \    'left': [
        \      ['mode', 'paste'],
        \      ['readonly', 'filename', 'modified', 'dir'],
        \      ['coc_status_error', 'coc_status_warning', 'coc_status_info'],
        \      ['anzu'],
        \    ],
        \    'right': [
        \      ['lineinfo', 'rows'],
        \      ['fileencoding', 'filetype'],
        \      ['ale_checking', 'ale_errors', 'ale_warnings', 'ale_ok'],
        \    ],
        \  },
        \  'inactive': {
        \    'left': [
        \      ['filename', 'modified'],
        \      ['dir'],
        \    ],
        \    'right': [
        \      ['lineinfo', 'rows'],
        \      ['fileencoding', 'filetype'],
        \    ],
        \  },
        \  'tabline': {
        \    'left': [
        \      ['tabs', 'git_changes']
        \    ],
        \    'right': [],
        \  },
        \  'component': {
        \    'dir': '%.35(%{expand("%:h:s?\\S$?\\0/?")}%)',
        \    'rows': '%LL',
        \  },
        \  'component_function': {
        \    'readonly': 'plugin#lightline#readonly',
        \    'anzu': 'anzu#search_status',
        \    'ale_ok': 'lightline#ale#ok',
        \    'coc_status_info': 'plugin#lightline#coc_status_info',
        \    'git_changes': 'plugin#lightline#coc_git_changes',
        \  },
        \  'component_expand': {
        \    'ale_checking': 'lightline#ale#checking',
        \    'ale_warnings': 'lightline#ale#warnings',
        \    'ale_errors': 'lightline#ale#errors',
        \    'coc_status_error': 'plugin#lightline#coc_status_error',
        \    'coc_status_warning': 'plugin#lightline#coc_status_warning',
        \  },
        \  'component_type': {
        \    'ale_checking': 'left',
        \    'ale_warnings': 'warning',
        \    'ale_errors': 'error',
        \    'coc_status_error': 'error',
        \    'coc_status_warning': 'warning',
        \  },
        \}

  let s:palette = g:lightline#colorscheme#onedark#palette
  let s:palette.inactive.left[0] = s:palette.inactive.right[0]
  let s:palette.normal.left[0] = ['#282C34', '#99CC99', 12, 11]
  let s:palette.normal.right[0] = ['#282C34', '#99CC99', 12, 11]
endfunction

function! plugin#lightline#autocmd() abort
  augroup lightline
    autocmd!
    autocmd User CocDiagnosticChange,CocGitStatusChange call lightline#update()
  augroup END
endfunction

function! plugin#lightline#readonly()
  return &readonly || &filetype == 'help' ? '👀' : ''
endfunction

function! plugin#lightline#coc_status_error() abort
  let count = get(get(b:, 'coc_diagnostic_info', {}), 'error', 0)
  return count == 0 ? '' : get(g:, 'coc_status_error_sign', 'E: ') . count
endfunction

function! plugin#lightline#coc_status_warning() abort
  let count = get(get(b:, 'coc_diagnostic_info', {}), 'warning', 0)
  return count == 0 ? '' : get(g:, 'coc_status_warning_sign', 'W: ') . count
endfunction

function! plugin#lightline#coc_status_info() abort
  let count = get(get(b:, 'coc_diagnostic_info', {}), 'information', 0)
  return count == 0 ? '' : get(g:, 'coc_status_info_sign', 'I: ') . count
endfunction

function! plugin#lightline#coc_git_changes() abort
  return get(b:, 'coc_git_status', '')
endfunction
