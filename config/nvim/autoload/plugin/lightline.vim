function! plugin#lightline#set_variables() abort
  let g:lightline = {
        \  'colorscheme': 'onedark',
        \  'active': {
        \    'left': [
        \      ['mode', 'paste'],
        \      ['readonly', 'file_status', 'notif'],
        \      ['lsp_diagnositc_error', 'lsp_diagnositc_warning', 'lsp_diagnositc_info', 'lsp_diagnositc_hint'],
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
        \    'fileencoding': 'plugin#lightline#fileencoding',
        \    'mode': 'plugin#lightline#mode',
        \    'yarn_start_status': 'plugin#lightline#yarn_start_status',
        \    'notif': 'plugin#lightline#notif_status',
        \  },
        \  'component_expand': {
        \    'file_status': 'plugin#lightline#file_status',
        \    'ale_checking': 'lightline#ale#checking',
        \    'ale_errors': 'lightline#ale#errors',
        \    'ale_warnings': 'lightline#ale#warnings',
        \    'lsp_diagnositc_error': 'plugin#lightline#lsp_diagnositc_error',
        \    'lsp_diagnositc_warning': 'plugin#lightline#lsp_diagnositc_warning',
        \    'lsp_diagnositc_info': 'plugin#lightline#lsp_diagnositc_info',
        \    'lsp_diagnositc_hint': 'plugin#lightline#lsp_diagnositc_hint',
        \    'git_changes': 'plugin#lightline#git_changes',
        \    'readonly': 'plugin#lightline#readonly',
        \  },
        \  'component_type': {
        \    'ale_checking': 'left',
        \    'ale_errors': 'error',
        \    'ale_warnings': 'warning',
        \    'lsp_diagnositc_error': 'error',
        \    'lsp_diagnositc_warning': 'warning',
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
    hi TerminalCurrentDirectory guifg=#F99157 guibg=#3E4452
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
  if &fileencoding ==# 'utf-8' || &encoding ==# 'utf-u'
    return ''
  endif

  return &fileencoding !=# '' ? &fileencoding : &encoding
endfunction

function! plugin#lightline#lsp_diagnositc_error() abort
  const count = luaeval('vim.lsp.diagnostic.get_count(0, "Error")')
  return count == 0 ? '' : 'E: ' . count
endfunction

function! plugin#lightline#lsp_diagnositc_warning() abort
  const count = luaeval('vim.lsp.diagnostic.get_count(0, "Warning")')
  return count == 0 ? '' : 'W: ' . count
endfunction

function! plugin#lightline#lsp_diagnositc_info() abort
  const count = luaeval('vim.lsp.diagnostic.get_count(0, "Information")')
  return count == 0 ? '' : 'I: ' . count
endfunction

function! plugin#lightline#lsp_diagnositc_hint() abort
  const count = luaeval('vim.lsp.diagnostic.get_count(0, "Hint")')
  return count == 0 ? '' : 'H: ' . count
endfunction

function! plugin#lightline#git_changes() abort
  let [added, modified, removed] = GitGutterGetHunkSummary()
  return added + modified + removed == 0 ? '' : printf('+%d ~%d -%d', added, modified, removed)
endfunction

function! plugin#lightline#yarn_start_status() abort
  return exists('g:yarn_start_job_id') ? 'Y' : ''
endfunction

function! plugin#lightline#notif_status() abort
  return get(g:, 'github_notif_unread', 0) ? '!' : ''
endfunction

function! plugin#lightline#automcd() abort
  augroup plugin#lightline
    autocmd!
    autocmd User GitGutter,LspDiagnosticsChanged call lightline#update()
  augroup END
endfunction
