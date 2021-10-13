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

set_highlight('ALEErrorSign', { guibg = colors.base08 })
set_highlight('ALEErrorSign', { guibg = colors.base08 })
set_highlight('ALEStyleErrorSign', { guibg = colors.base0A })
set_highlight('Comment', { guifg = colors.base03, gui = 'italic' })
set_highlight('CursorLineNr', {  guifg = colors.base04, guibg = '#202020', gui = 'bold' })
set_highlight('LineNr', { guifg = colors.base04, guibg = colors.base01 })
set_highlight('TSVariable', { guifg = colors.base05 })
set_highlight('TSVariableBuiltin', { guifg = colors.base05, gui = 'italic' })
set_highlight('TSKeywordReturn', { guifg = colors.base08 })
set_highlight('TerminalCurrentDirectory', { guifg=colors.base09, guibg='#3E4452' })
set_highlight('TSPunctSpecial', { guifg=colors.base0C })
set_highlight('TSPunctBracket', { guifg=colors.base0D })
set_highlight('TSInclude', { guifg=colors.base0E })
EOF

highlight DiffAdd guifg=NONE guibg=#334539
highlight DiffChange guifg=NONE guibg=#454133
highlight DiffDelete guifg=NONE guibg=#45333a
highlight DiffText guifg=NONE guibg=#5f5d42
highlight GitSignsAddNr guibg=#5C6E5C
highlight GitSignsChangeDeleteNr gui=underline guibg=#786A51
highlight GitSignsChangeNr guibg=#786A51
highlight GitSignsDeleteNr guibg=#764C4F
highlight IncSearch guifg=NONE guibg=#45333a
highlight Search guifg=NONE guibg=#454133
highlight SignColumn guibg=NONE
highlight Substitute guifg=NONE guibg=#454133
highlight Yanked guibg=#134a28

highlight link EndOfBuffer Ignore
highlight! link gitcommitComment Comment
