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
