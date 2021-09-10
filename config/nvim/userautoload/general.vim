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

if executable('rg')
  set grepprg=rg\ --vimgrep
  set grepformat=%f:%l:%c:%m

  " Doubly escape `|` because the backslash before `|`` will be removed by the `:!` command
  " Unescape `!`
  command! -range -nargs=* -complete=file GrepRange
        \ execute(printf(
        \   'grep --multiline %s <args>',
        \   substitute(shellescape(join(map(getline('<line1>', '<line2>'), {
        \     _, val -> escape(escape(val, '.+*?{}[]()^$|\'), '|')
        \   }), "\n"), 1), '\\!', '!', 'g')
        \ ))
endif

" autocmd
augroup init_vim
  autocmd!
  autocmd BufEnter * setlocal formatoptions-=cro
  autocmd BufReadPre *.tsx call dein#source('vim-jsx-pretty')
  autocmd QuickFixCmdPost *grep* cwindow
  autocmd VimLeave * set guicursor=a:ver25
  autocmd TermOpen * setlocal signcolumn=no | tnoremap <buffer> <C-q> <C-\><C-n>
  autocmd FileType gitcommit,gitrebase setlocal bufhidden=delete
  autocmd FileType markdown setlocal listchars+=trail:·
  autocmd FileType vim autocmd OptionSet * ++once setlocal iskeyword-=#
augroup END

augroup line_number
  let filetypes = ['toggleterm', 'man']
  autocmd!
  autocmd FileType fzf autocmd OptionSet * ++once setlocal nonumber norelativenumber
  autocmd FileType help autocmd OptionSet * ++once setlocal number norelativenumber
  autocmd FileType toggleterm autocmd OptionSet * ++once startinsert
  autocmd BufEnter,InsertLeave,WinEnter * if index(filetypes, &ft, 0, v:true) >= 0 |
              \   setlocal nonumber norelativenumber |
              \ else |
              \   setlocal number relativenumber |
              \ endif
  autocmd BufLeave,InsertEnter,WinLeave * if index(filetypes, &ft, 0, v:true) >= 0 |
              \   setlocal nonumber norelativenumber |
              \ else |
              \   setlocal number norelativenumber |
              \ endif
augroup END
