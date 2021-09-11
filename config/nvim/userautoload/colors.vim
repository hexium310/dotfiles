set termguicolors
colorscheme base16-tomorrow-night-eighties

lua << EOF
local base16 = require('base16-colorscheme')
local highlight = base16.highlight
local colors = base16.colorschemes['tomorrow-night-eighties']

highlight.ALEErrorSign = { guibg = colors.base08 }
highlight.ALEStyleErrorSign = { guibg = colors.base0A }
highlight.Comment = { guifg = colors.base03, gui = 'italic' }
highlight.CursorLineNr = {  guifg = colors.base04, guibg = '#202020', gui = 'bold' }
highlight.LineNr = { guifg = colors.base04, guibg = colors.base01 }
highlight.TSVariable = { guifg = colors.base05 }
highlight.TSVariableBuiltin = { guifg = colors.base05, gui = 'italic' }
highlight.TSKeywordReturn = { guifg = colors.base08 }
highlight.TerminalCurrentDirectory = { guifg=colors.base09, guibg='#3E4452' }
highlight.TSPunctSpecial = { guifg=colors.base0C }
highlight.TSPunctBracket = { guifg=colors.base0D }
highlight.TSInclude = { guifg=colors.base0E }
EOF

highlight DiffAdd guifg=NONE guibg=#334539
highlight DiffChange guifg=NONE guibg=#454133
highlight DiffDelete guifg=NONE guibg=#45333a
highlight DiffText guifg=NONE guibg=#5f5d42
highlight Yanked guibg=#134a28
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
highlight! link gitcommitComment Comment
