nnoremap + <C-a>
nnoremap - <C-x>
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l
nnoremap <S-Left> ^
nnoremap <S-Right> $
nnoremap [d [c
nnoremap ]d ]c
nnoremap s <Nop>
vnoremap v $h

augroup mappings
  autocmd!
  autocmd FileType man nmap <buffer> K K
augroup END

inoremap <F1> <Nop>
nnoremap <F1> <Nop>
nnoremap q <Nop>
nnoremap qq q
nnoremap q: <Nop>
noremap <C-q> <Nop>

iabbrev :w <C-g>u:w
