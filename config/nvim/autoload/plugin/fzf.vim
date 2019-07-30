function! plugin#fzf#set_variables() abort
  let g:fzf_rg_glob_files = [
        \   '!LICENSE',
        \   '!README.md',
        \   '!yarn.lock',
        \   '!package-lock.json',
        \ ]
  let g:fzf_rg_glob = join(map(g:fzf_rg_glob_files, '"-g ''" . v:val . "''"'), ' ')
endfunction

function! plugin#fzf#set_maps() abort
  nnoremap <silent> <C-p> :GFiles -co --exclude-standard<Cr>
  nnoremap <silent> <C-m> :History<Cr>
  nnoremap <silent> tt :Buffers<Cr>
endfunction

function! plugin#fzf#set_commands() abort
  command! -bang -nargs=* Rg call fzf#vim#grep(
        \ 'rg --line-number --no-heading --color=always ' . g:fzf_rg_glob . ' ' . shellescape(<q-args>),
        \   0,
        \   fzf#vim#with_preview(
        \     { 'options': '--color --exact --delimiter : --nth 3..' },
        \     'up:50%'
        \   ),
        \   <bang>1
        \ )
endfunction

function! plugin#fzf#autocmd() abort
  augroup fzf
    autocmd FileType fzf tunmap <buffer> <Esc>
  augroup END
endfunction
