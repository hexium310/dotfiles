" General
language en_US.UTF-8
set backspace=
set cindent
set expandtab
set noswapfile
set nowritebackup
set pyxversion=3
set shiftwidth=4
set tabstop=4
set title
set updatetime=300
set virtualedit=block
set whichwrap=
set mouse=

" Display
filetype plugin indent on
set completeopt-=preview
set cursorline
set cursorlineopt=number
set diffopt+=vertical
set fillchars=diff:\ ,
set lazyredraw
set list
set listchars=tab:»-
set nofoldenable
set noshowmode
set nowrap
set number
set numberwidth=7
set pumheight=20
set relativenumber
set scrolloff=2
set shortmess+=cs
set showtabline=2
set signcolumn=yes
set splitbelow
set splitright
let g:loaded_matchit = v:true
let g:loaded_matchparen = v:true

" Search
set ignorecase
set smartcase
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
  autocmd QuickFixCmdPost *grep* cwindow
  autocmd VimLeave * set guicursor=a:ver25
  autocmd TermOpen * setlocal signcolumn=no | tnoremap <buffer> <C-q> <C-\><C-n>
  autocmd FileType gitcommit,gitrebase setlocal bufhidden=delete
  autocmd FileType markdown setlocal listchars+=trail:·
  autocmd FileType vim autocmd OptionSet * ++once setlocal iskeyword-=#
  autocmd TextYankPost * silent! lua vim.highlight.on_yank({ higroup = 'Yanked', timeout = 100 })
  autocmd BufEnter * if ! exists('b:terminal_job_id') | setlocal winhighlight= | endif
augroup END

augroup line_number
  let filetypes = ['toggleterm', 'man']
  autocmd!
  autocmd FileType fzf autocmd OptionSet * ++once setlocal nonumber norelativenumber
  autocmd FileType help autocmd OptionSet * ++once setlocal number norelativenumber
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
