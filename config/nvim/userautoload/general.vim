" General
language en_US.UTF-8
set encoding=utf-8
set hidden
set expandtab
set shiftwidth=4
set tabstop=4
set cindent
set title
set whichwrap=b,s,h,l,<,>,[,],~
set backspace=indent,eol,start
set virtualedit=block
set updatetime=300
set pyxversion=3
set nobackup
set nowritebackup
set noswapfile

" Display
filetype plugin indent on
set list
set listchars=tab:»-
set scrolloff=2
set noshowmode
set novisualbell
set nofoldenable
set number
set relativenumber
set numberwidth=5
set showtabline=2
set laststatus=2
set ambiwidth=single
set nowrap
set lazyredraw
set splitright
set splitbelow
set shortmess+=cs
set completeopt-=preview
set pumheight=20
set cursorline
set signcolumn=yes

" Search
set ignorecase
set smartcase
set wrapscan
set hlsearch
if exists('&inccommand')
  set inccommand=split
endif

let $GIT_EDITOR = 'nvr --remote-tab-wait'

" autocmd
augroup init_vim
  autocmd!
  autocmd BufEnter * setlocal formatoptions-=cro
  autocmd BufReadPre *.tsx call dein#source('vim-jsx-pretty')
  autocmd QuickFixCmdPost *grep* cwindow
  autocmd VimLeave * set guicursor=a:ver25
  autocmd TermOpen * startinsert | setlocal signcolumn=no | tnoremap <buffer> <C-q> <C-\><C-n> | set filetype=terminal
  autocmd BufWritePre * call utils#remove_multiple_empty_lines([
        \'typescript',
        \'typescriptreact',
        \'javascript',
        \'javascriptreact'
        \])
  autocmd FileType gitcommit,gitrebase setlocal bufhidden=delete
  autocmd FileType markdown setlocal listchars+=trail:·
  autocmd FileType vim autocmd OptionSet * ++once setlocal iskeyword-=#
augroup END

augroup line_number
  autocmd!
  autocmd FileType fzf autocmd OptionSet * ++once setlocal nonumber norelativenumber
  autocmd FileType list,help autocmd OptionSet * ++once setlocal number norelativenumber
  autocmd FileType terminal autocmd BufEnter * ++once setlocal norelativenumber
  autocmd BufEnter,InsertLeave,WinEnter * setlocal relativenumber
  autocmd BufLeave,InsertEnter,WinLeave,TermEnter * setlocal norelativenumber
  autocmd BufRead,BufWrite *.zunit setlocal foldenable foldcolumn=5 foldtext=utils#fold_text(b:gitgutter_sign_lnums) foldopen=insert,mark,quickfix,search,tag,undo foldclose=all | autocmd User GitGutter ++once call utils#fold_place_without_gitgutter_sign()
augroup END
