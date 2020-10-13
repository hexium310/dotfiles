" General
language en_US.UTF-8
set backspace=
set cindent
set encoding=utf-8
set expandtab
set hidden
set nobackup
set noswapfile
set nowritebackup
set pyxversion=3
set shiftwidth=4
set tabstop=4
set title
set updatetime=300
set virtualedit=block
set whichwrap=

" Display
filetype plugin indent on
set ambiwidth=single
set completeopt-=preview
set cursorline
set diffopt+=vertical
set fillchars=diff:\ ,
set laststatus=2
set lazyredraw
set list
set listchars=tab:»-
set nofoldenable
set noshowmode
set novisualbell
set nowrap
set number
set numberwidth=5
set pumheight=20
set relativenumber
set scrolloff=2
set shortmess+=cs
set showtabline=2
set signcolumn=yes
set splitbelow
set splitright

" Search
set hlsearch
set ignorecase
set smartcase
set wrapscan
if exists('&inccommand')
  set inccommand=split
endif

if executable('nvr')
  let $GIT_EDITOR = 'nvr --remote-tab-wait'
endif

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
augroup END
