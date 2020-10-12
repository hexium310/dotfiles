nnoremap + <C-a>
nnoremap - <C-x>
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l
nnoremap <S-Left> ^
nnoremap <S-Right> $
nnoremap <silent> <Space>j :call utils#insert_newline_in_element_attributes()<Cr>
nnoremap <silent> <Space>s :call utils#open_terminal()<Cr>
nnoremap [d [c
nnoremap ]d ]c
nnoremap s <Nop>
vnoremap v $h

inoremap <F1> <Nop>
nnoremap <F1> <Nop>
nnoremap q: <Nop>
noremap <C-q> <Nop>

command! YDisplay call utils#show_yarn_start()
command! YRun call utils#run_yarn_start()
command! YStop call utils#stop_yarn_start()
