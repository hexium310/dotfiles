set termguicolors
colorscheme base16-tomorrow-night-eighties

lua << EOF
local base16 = require('base16-colorscheme')
local colors = base16.colorschemes['tomorrow-night-eighties']

local function set_highlight(name, opt)
  local cmd = {}
  table.insert(cmd, 'highlight')
  table.insert(cmd, name)
  for k, v in pairs(opt) do
    table.insert(cmd, k .. '=' .. v)
  end
  vim.cmd(table.concat(cmd, ' '))
end

set_highlight('Comment', { guifg = colors.base03, gui = 'italic' })
set_highlight('CursorLineNr', { guifg = colors.base04, guibg = '#202020', gui = 'bold' })
set_highlight('DiagnosticWarn', { guifg = colors.base0A })
set_highlight('DiagnosticUnderlineWarn', { guisp = colors.base0A, gui = 'undercurl' })
set_highlight('LineNr', { guifg = colors.base04, guibg = colors.base01 })
set_highlight('TSVariable', { guifg = colors.base05 })
set_highlight('TSVariableBuiltin', { guifg = colors.base05, gui = 'italic' })
set_highlight('TSKeywordReturn', { guifg = colors.base08 })
set_highlight('TerminalCurrentDirectory', { guifg = colors.base09, guibg = '#3E4452' })
set_highlight('TSPunctSpecial', { guifg = colors.base0C })
set_highlight('TSPunctBracket', { guifg = colors.base0D })
set_highlight('TSInclude', { guifg = colors.base0E })
set_highlight('CmpItemAbbr', { guifg = colors.base03 })
set_highlight('CmpItemAbbrDeprecated', { guifg = colors.base03, gui = 'italic' })
set_highlight('CmpItemAbbrMatch', { guifg = colors.base05, gui = 'bold' })
set_highlight('CmpItemAbbrMatchFuzzy', { guifg = colors.base05, gui = 'bold' })
set_highlight('CmpItemKind', { guifg = colors.base0C })
set_highlight('CmpItemMenu', { guifg = colors.base03 })
set_highlight('GitSignsAddInline', { guifg = colors.base00, guibg = colors.base0B })
set_highlight('GitSignsDeleteInline', { guifg = colors.base00, guibg = colors.base08 })
EOF

highlight DiffAdd guifg=NONE guibg=#334539
highlight DiffChange guifg=NONE guibg=#454133
highlight DiffDelete guifg=NONE guibg=#45333a
highlight DiffText guifg=NONE guibg=#5f5d42
highlight GitSignsAddNr guibg=#5C6E5C
highlight GitSignsChangeDeleteNr gui=underline guibg=#786A51
highlight GitSignsChangeNr guibg=#786A51
highlight GitSignsDeleteNr guibg=#764C4F
highlight GitSignsDeleteLn guibg=#45333a
highlight IncSearch guifg=NONE guibg=#45333a
highlight Search guifg=NONE guibg=#454133
highlight SignColumn guibg=NONE
highlight Substitute guifg=NONE guibg=#454133
highlight Yanked guibg=#134a28
highlight MatchParen gui=reverse guibg=NONE
highlight MatchParenCur guibg=#515151
highlight MatchWord guibg=#454545
highlight MatchWordCur guibg=#515151
highlight ConflictMarkerBegin guibg=#255c51
highlight ConflictMarkerEnd guibg=#254e71
highlight ConflictMarkerOurs guibg=#203833
highlight ConflictMarkerTheirs guibg=#243749
highlight ConflictMarkerCommonAncestorsHunk guibg=#51335a

highlight link EndOfBuffer Ignore
highlight! link gitcommitComment Comment
