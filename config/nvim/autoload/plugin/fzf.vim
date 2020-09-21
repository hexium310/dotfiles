function! plugin#fzf#set_variables() abort
  const fzf_rg_glob_files = [
        \   '!LICENSE',
        \   '!README.md',
        \   '!yarn.lock',
        \   '!package-lock.json',
        \ ]
  const s:fzf_rg_glob = join(map(copy(fzf_rg_glob_files), { _, file -> printf("-g %s", file) }), ' ')
  const s:fzf_ripgrep_command_format = 'rg --column --line-number --no-heading --color=always --smart-case %s -- %s'
  let g:fzf_statusline = 0
  let g:fzf_nvim_statusline = 0
  let g:fzf_layout = { 'window': { 'width': 0.9, 'height': 0.8 } }
endfunction

function! plugin#fzf#set_maps() abort
  nnoremap <silent> <C-p> :GFiles -co --exclude-standard<Cr>
  nnoremap <silent> <Space><C-m> :History<Cr>
  nnoremap <silent> <Space>e :Buffers<Cr>
endfunction

function! plugin#fzf#set_commands() abort
  command! -bang -nargs=* Rg call fzf#vim#grep(
        \   printf(s:fzf_ripgrep_command_format, s:fzf_rg_glob, shellescape(<q-args>)),
        \   1,
        \   fzf#vim#with_preview({}, 'up:50%'),
        \   <bang>0
        \ )
  command! -bang -nargs=* RG call plugin#fzf#ripgrep_fzf(<q-args>, <bang>0)
  command! -nargs=0 EditNew call plugin#fzf#new_file()

  const s:colorizing = '| ' . $FZF_DEFAULT_COMMAND
  command! -bang -nargs=? -complete=dir Files
        \ call fzf#vim#files(<q-args>, s:p(<bang>0, { 'options': ['--ansi'] }), <bang>0)
  command! -bang -nargs=? GFiles
        \ call fzf#vim#gitfiles(<q-args> . s:colorizing, <q-args> == "?" ? { 'options': ['--ansi'] } : s:p(<bang>0, { 'options': ['--ansi'] }), <bang>0)
endfunction

function! plugin#fzf#new_file() abort
  function! Callback(line) abort
    const file = input('New file: ', a:line . '/')
    execute 'edit' file
  endfunction

  call fzf#run(fzf#wrap({
        \  'source': 'fd -H --type=directory --exclude=.git/',
        \  'sink': { line -> execute('call timer_start(0, { -> Callback(line) })') },
        \  'options': '--prompt="Directory> "'
        \}))
endfunction

function! plugin#fzf#ripgrep_fzf(query, fullscreen)
  const command_fmt = s:fzf_ripgrep_command_format . ' || true'
  const initial_command = printf(command_fmt, s:fzf_rg_glob, shellescape(a:query))
  const reload_command = printf(command_fmt, s:fzf_rg_glob, '{q}')
  const spec = {
        \   'options': [
        \     '--phony',
        \     '--query', a:query,
        \     '--bind', 'change:reload:'.reload_command,
        \   ],
        \}

  call fzf#vim#grep(initial_command, 1, fzf#vim#with_preview(spec, 'up:50%'), a:fullscreen)
endfunction

function! s:p(bang, ...)
  if a:bang
    return s:get_fzf_vim_sid()(a:bang, a:1)
  else
    return a:1
  endif
endfunction

function! s:get_fzf_vim_sid()
  let scriptname = ''
  redir => scriptname
  silent! filter fzf.vim/plugin/fzf.vim scriptnames
  redir END
  const sid = substitute(trim(scriptname), '^\s*\(\d\+\):.*', '\1', '')
  return function('<SNR>' . sid . '_p')
endfunction
