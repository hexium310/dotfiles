nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l
nnoremap <S-Up> <NOP>
nnoremap <S-Down> <NOP>
nnoremap <S-Left> <NOP>
nnoremap <S-Right> <NOP>
nnoremap [d [c
nnoremap ]d ]c
nnoremap s <NOP>
vnoremap v $h

augroup mappings
  autocmd!
  autocmd FileType man nmap <buffer> K K
augroup END

inoremap <F1> <NOP>
nnoremap <F1> <NOP>
nnoremap q <NOP>
nnoremap qq q
nnoremap q: <NOP>
noremap <C-q> <NOP>

iabbrev :w <C-g>u:w
