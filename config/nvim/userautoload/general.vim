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
  autocmd BufEnter * setlocal formatoptions-=c formatoptions-=r formatoptions-=o
  autocmd BufReadPre *.tsx call dein#source('vim-jsx-pretty')
  autocmd QuickFixCmdPost *grep* cwindow
  autocmd VimLeave * set guicursor=a:ver25
  autocmd TermOpen * startinsert | setlocal signcolumn=no | tnoremap <buffer> <C-q> <C-\><C-n>
  autocmd BufWritePre * call utils#remove_multiple_empty_lines(['typescript', 'javascript'])
  autocmd FileType gitcommit,gitrebase setlocal bufhidden=delete
  autocmd FileType markdown let &listchars .=",trail:·"
  autocmd FileType list highlight CursorLine gui=bold
  autocmd FileType typescript nnoremap <silent><buffer> gf :call plugin#tsgf#findFile()<Cr>
augroup END
