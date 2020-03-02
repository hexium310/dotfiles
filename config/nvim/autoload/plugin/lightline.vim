function! plugin#lightline#set_variables() abort
  let g:lightline = {
        \  'colorscheme': 'onedark',
        \  'active': {
        \    'left': [
        \      ['mode', 'paste'],
        \      ['readonly', 'file_status'],
        \      ['coc_status_error', 'coc_status_warning', 'coc_status_info'],
        \      ['anzu'],
        \    ],
        \    'right': [
        \      ['lineinfo', 'rows'],
        \      ['fileencoding', 'filetype'],
        \      ['yarn_start_status', 'ale_checking', 'ale_errors', 'ale_warnings'],
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
        \    'rows': '%LL',
        \  },
        \  'component_function': {
        \    'anzu': 'anzu#search_status',
        \    'coc_status_info': 'plugin#lightline#coc_status_info',
        \    'file_status': 'plugin#lightline#file_status',
        \    'fileencoding': 'plugin#lightline#fileencoding',
        \    'git_changes': 'plugin#lightline#coc_git_changes',
        \    'mode': 'plugin#lightline#mode',
        \    'yarn_start_status': 'plugin#lightline#yarn_start_status',
        \  },
        \  'component_expand': {
        \    'ale_checking': 'lightline#ale#checking',
        \    'ale_errors': 'lightline#ale#errors',
        \    'ale_warnings': 'lightline#ale#warnings',
        \    'coc_status_error': 'plugin#lightline#coc_status_error',
        \    'coc_status_warning': 'plugin#lightline#coc_status_warning',
        \    'readonly': 'plugin#lightline#readonly',
        \  },
        \  'component_type': {
        \    'ale_checking': 'left',
        \    'ale_errors': 'error',
        \    'ale_warnings': 'warning',
        \    'coc_status_error': 'error',
        \    'coc_status_warning': 'warning',
        \    'readonly': 'error',
        \  },
        \}

  const s:palette = g:lightline#colorscheme#onedark#palette
  let s:palette.inactive.left[0] = s:palette.inactive.right[0]
  let s:palette.normal.left[0] = ['#282C34', '#99CC99', 12, 11]
  let s:palette.normal.right[0] = ['#282C34', '#99CC99', 12, 11]
endfunction

function! plugin#lightline#readonly() abort
  return &readonly ? 'RO' : ''
endfunction

function! plugin#lightline#file_status() abort
  if &filetype ==# 'fzf'
    return ''
  endif

  const filename = expand('%:t')
  const modified = &modified ? ' +' : ''
  const directory = printf('%.35s', substitute(expand('%:h:s'), '\S$', '\0/', ''))
  return filename !=# '' ? lightline#concatenate([filename . modified, directory], 0) : '[No Name]'
endfunction

function! plugin#lightline#mode() abort
  if &filetype ==# 'fzf'
    return 'FZF'
  endif

  if &filetype ==# 'list'
    return 'COC'
  endif

  return lightline#mode()
endfunction

function! plugin#lightline#fileencoding() abort
  if &fileencoding ==# 'utf-8' || &encoding ==# 'utf-u'
    return ''
  endif

  return &fileencoding !=# '' ? &fileencoding : &encoding
endfunction

function! plugin#lightline#coc_status_error() abort
  const count = plugin#lightline#coc_diagnostic_count('error')
  return count == 0 ? '' : get(g:, 'coc_status_error_sign', 'E: ') . count
endfunction

function! plugin#lightline#coc_status_warning() abort
  const count = plugin#lightline#coc_diagnostic_count('warning')
  return count == 0 ? '' : get(g:, 'coc_status_warning_sign', 'W: ') . count
endfunction

function! plugin#lightline#coc_status_info() abort
  const count = plugin#lightline#coc_diagnostic_count('information')
  return count == 0 ? '' : get(g:, 'coc_status_info_sign', 'I: ') . count
endfunction

function! plugin#lightline#coc_diagnostic_count(type) abort
  return get(get(b:, 'coc_diagnostic_info', {}), a:type, 0)
endfunction

function! plugin#lightline#coc_git_changes() abort
  return trim(get(b:, 'coc_git_status', ''))
endfunction

function! plugin#lightline#yarn_start_status() abort
  return exists('g:yarn_start_job_id') ? 'Y' : ''
endfunction
