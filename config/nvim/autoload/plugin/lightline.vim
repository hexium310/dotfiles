function! plugin#lightline#set_variables() abort
  let g:lightline = {
        \  'colorscheme': 'onedark',
        \  'active': {
        \    'left': [
        \      ['mode', 'paste'],
        \      ['readonly', 'file_status'],
        \      ['diagnostic_error', 'diagnostic_warning', 'diagnostic_info', 'diagnostic_hint'],
        \      ['anzu'],
        \    ],
        \    'right': [
        \      ['lineinfo'],
        \      ['fileencoding', 'filetype'],
        \      ['yarn_start_status'],
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
        \    'right': [
        \      ['git_head']
        \    ],
        \  },
        \  'component': {
        \    'rows': '%LL',
        \  },
        \  'component_function': {
        \    'anzu': 'anzu#search_status',
        \    'fileencoding': 'plugin#lightline#fileencoding',
        \    'mode': 'plugin#lightline#mode',
        \    'yarn_start_status': 'plugin#lightline#yarn_start_status',
        \  },
        \  'component_expand': {
        \    'file_status': 'plugin#lightline#file_status',
        \    'diagnostic_error': 'plugin#lightline#diagnostic_error',
        \    'diagnostic_warning': 'plugin#lightline#diagnostic_warning',
        \    'diagnostic_info': 'plugin#lightline#diagnostic_info',
        \    'diagnostic_hint': 'plugin#lightline#diagnostic_hint',
        \    'git_changes': 'plugin#lightline#git_changes',
        \    'git_head': 'plugin#lightline#git_head',
        \    'readonly': 'plugin#lightline#readonly',
        \  },
        \  'component_type': {
        \    'diagnostic_error': 'error',
        \    'diagnostic_warning': 'warning',
        \    'readonly': 'error',
        \  },
        \}

  let s:palette = g:lightline#colorscheme#onedark#palette
  let s:palette.inactive.left[0] = s:palette.inactive.right[0]
  let s:palette.normal.left[0] = ['#282C34', '#99CC99', 12, 11]
  let s:palette.normal.right[0] = ['#282C34', '#99CC99', 12, 11]
endfunction

function! s:IsTerminal() abort
  return exists('b:terminal_job_id')
endfunction

function! plugin#lightline#readonly() abort
  return &readonly ? 'RO' : ''
endfunction

function! plugin#lightline#file_status() abort
  if s:IsTerminal()
    let toggle_number = get(b:, 'toggle_number', 0)
    let toggleterm = toggle_number ? printf('#%s:', toggle_number) : ''

    if !exists('b:terminal_current_directory')
      if !exists('s:terminal_reloading')
        let s:terminal_reloading = timer_start(100, { -> lightline#update() }, { 'repeat': 50 })
      endif
      return toggleterm . '#toggleterm#'
    endif

    if exists('s:terminal_reloading')
      call timer_stop(s:terminal_reloading)
    endif
    return toggleterm . '%#TerminalCurrentDirectory#' . substitute(b:terminal_current_directory, expand('$HOME'), '~', '')
  endif

  if &filetype ==# 'fzf'
    return ''
  endif

  const filename = expand('%:t')
  const modified = &modified ? ' +' : ''
  const directory = printf('%.35s', substitute(expand('%:h:s'), '\S$', '\0/', ''))
  if directory =~# '^fugitive'
    return 'fugitive:' . filename
  endif
  return filename !=# '' ? lightline#concatenate([filename . modified, directory], 0) : '[No Name]'
endfunction

function! plugin#lightline#mode() abort
  if &filetype ==# 'fzf'
    return 'FZF'
  endif

  return lightline#mode()
endfunction

function! plugin#lightline#fileencoding() abort
  return &fileencoding ==# 'utf-8' ? '' : &fileencoding
endfunction

function! plugin#lightline#diagnostic_error() abort
  const count = luaeval('vim.tbl_count(vim.diagnostic.get(vim.api.nvim_get_current_buf(), { severity = vim.diagnostic.severity.ERROR }))')
  return count == 0 ? '' : 'E: ' . count
endfunction

function! plugin#lightline#diagnostic_warning() abort
  const count = luaeval('vim.tbl_count(vim.diagnostic.get(vim.api.nvim_get_current_buf(), { severity = vim.diagnostic.severity.WARN }))')
  return count == 0 ? '' : 'W: ' . count
endfunction

function! plugin#lightline#diagnostic_info() abort
  const count = luaeval('vim.tbl_count(vim.diagnostic.get(vim.api.nvim_get_current_buf(), { severity = vim.diagnostic.severity.INFO }))')
  return count == 0 ? '' : 'I: ' . count
endfunction

function! plugin#lightline#diagnostic_hint() abort
  const count = luaeval('vim.tbl_count(vim.diagnostic.get(vim.api.nvim_get_current_buf(), { severity = vim.diagnostic.severity.HINT }))')
  return count == 0 ? '' : 'H: ' . count
endfunction

function! plugin#lightline#git_changes() abort
  return get(b:, 'gitsigns_status', '')
endfunction

function! plugin#lightline#git_head() abort
  return get(b:, 'gitsigns_head', '')
endfunction

function! plugin#lightline#yarn_start_status() abort
  return exists('g:yarn_start_job_id') ? 'Y' : ''
endfunction

function! plugin#lightline#automcd() abort
  augroup plugin#lightline
    autocmd!
    autocmd DiagnosticChanged * call lightline#update()
  augroup END
endfunction
