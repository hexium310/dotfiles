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
set shortmess+=cs
set completeopt-=preview
set pumheight=10
set cursorline

" Search
set ignorecase
set smartcase
set wrapscan
set hlsearch
if exists('&inccommand')
  set inccommand=split
endif

" autocmd
augroup init_vim
  autocmd!
  autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o
augroup END
