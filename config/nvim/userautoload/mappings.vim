nnoremap <S-Left> ^
nnoremap <S-Right> $
nnoremap <silent> tc :tablast <bar> tabnew<Cr>
nnoremap <silent> tx :tabclose<Cr>
nnoremap <silent> tn :tabnext<Cr>
nnoremap <silent> tp :tabprevious<Cr>
nnoremap + <C-a>
nnoremap - <C-x>
vnoremap v $h
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l
nnoremap <Space>y "+y
vnoremap <Space>y "+y
nnoremap <Space>d "+d
vnoremap <Space>d "+d
nnoremap <Space>p "+p
vnoremap <Space>p "+p
nnoremap <Space>P "+P
vnoremap <Space>P "+P
nnoremap <silent> <Space>s :sp \| call OpenTerm() \| startinsert<Cr>

nnoremap <F1> <Nop>
inoremap <F1> <Nop>
nnoremap q: <Nop>


function! OpenTerm()
  let s:buf_list = execute('buffers')
  let s:reversed_list = join(reverse(split(s:buf_list, '\n')), "\n")
  let s:term_match = matchlist(s:reversed_list, '\v\d+ .{5}"(term://.{-})"')
  if len(s:term_match) != 0 && s:term_match[1] != ''
    execute('e ' . s:term_match[1])
  else
    execute('terminal')
  endif
endfunction
