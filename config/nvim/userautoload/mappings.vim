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
imap <C-k>     <Plug>(neosnippet_expand_or_jump)
smap <C-k>     <Plug>(neosnippet_expand_or_jump)
xmap <C-k>     <Plug>(neosnippet_expand_target)
imap <expr><Tab> neosnippet#expandable_or_jumpable() ? "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"

nnoremap <F1> <Nop>
inoremap <F1> <Nop>
