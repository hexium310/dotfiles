set termguicolors
colorscheme base16-tomorrow-night-eighties

lua << EOF
local base16 = require('base16-colorscheme')
local highlight = base16.highlight
local colors = base16.colorschemes['tomorrow-night-eighties']

highlight.ALEErrorSign = { guibg = colors.base08 }
highlight.ALEStyleErrorSign = { guibg = colors.base0A }
highlight.Comment = { guifg = colors.base03, gui = 'italic' }
highlight.CursorLineNr = { guifg=colors.base04, guibg='#202020', gui='bold' }
highlight.LineNr = { guifg=colors.base04, guibg=colors.base01 }
EOF

highlight DiffAdd guifg=NONE guibg=#334539
highlight DiffChange guifg=NONE guibg=#454133
highlight DiffDelete guifg=NONE guibg=#45333a
highlight DiffText guifg=NONE guibg=#5f5d42
highlight Flashy guibg=#134a28
highlight GitGutterAdd guibg=NONE
highlight GitGutterAddLineNr guibg=#5C6E5C
highlight GitGutterChange guibg=NONE
highlight GitGutterChangeDelete guibg=NONE
highlight GitGutterChangeDeleteLineNr gui=underline guibg=#786A51
highlight GitGutterChangeLineNr guibg=#786A51
highlight GitGutterDelete guibg=NONE
highlight GitGutterDeleteLineNr guibg=#764C4F
highlight IncSearch guifg=NONE guibg=#45333a
highlight Search guifg=NONE guibg=#454133
highlight SignColumn guibg=NONE
highlight Substitute guifg=NONE guibg=#454133

highlight clear CursorLine
highlight link EndOfBuffer Ignore
highlight link TSInclude Keyword
highlight link TSRepeat Keyword
highlight link TSParameter Constant
highlight link TSOperator Special
highlight! link gitcommitComment Comment
