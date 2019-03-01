"Use 24-bit (true-color) mode in Vim/Neovim when outside tmux.
"If you're using tmux version 2.2 or later, you can remove the outermost $TMUX check and use tmux's 24-bit color support
"(see < http://sunaku.github.io/tmux-24bit-color.html#usage > for more information.)
if (empty($TMUX))
  if (has("nvim"))
    "For Neovim 0.1.3 and 0.1.4 < https://github.com/neovim/neovim/pull/2198 >
    "let $NVIM_TUI_ENABLE_TRUE_COLOR=1
  endif
  "For Neovim > 0.1.5 and Vim > patch 7.4.1799 < https://github.com/vim/vim/commit/61be73bb0f965a895bfb064ea3e55476ac175162 >
  "Based on Vim patch 7.4.1770 (`guicolors` option) < https://github.com/vim/vim/commit/8a633e3427b47286869aa4b96f2bfc1fe65b25cd >
  " < https://github.com/neovim/neovim/wiki/Following-HEAD#20160511 >
  if (has("termguicolors"))
    set termguicolors
  endif
endif

let s:dein_dir = expand('$XDG_CACHE_HOME/dein')
let s:dein_core_dir = s:dein_dir . '/repos/github.com/Shougo/dein.vim'

if isdirectory(s:dein_core_dir)
  let &runtimepath .= ',' . s:dein_core_dir

  if dein#load_state(s:dein_dir)
    call dein#begin(s:dein_dir)

    for file in glob('$XDG_CONFIG_HOME/nvim/plugins/**/*.toml', 1, 1)
      call dein#load_toml(file)
    endfor

    if dein#check_install()
      call dein#install()
    endif

    call dein#end()
    call dein#save_state()
  endif
endif

runtime! userautoload/*.vim

" lightline
" tomlに書くと死ぬ
let s:palette = g:lightline#colorscheme#{g:lightline.colorscheme}#palette
let s:palette.tabline.left[0][0] = '#bbbbbb'

let g:gista#client#default_username = 'hexium310'
