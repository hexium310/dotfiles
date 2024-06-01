vim.o.termguicolors = true
if not pcall(vim.cmd.colorscheme, 'base16-tomorrow-night-eighties') then
  vim.cmd.colorscheme('habamax')
  return
end

local colors = require('base16-colorscheme').colors
local onedark = require('onedark.colors')
local set_highlights = require('plugins.utils').set_highlights

set_highlights({
  { '@include', { fg = colors.base0E } },
  { '@keyword.return', { fg = colors.base08 } },
  { '@lifetime', { link = 'Special' } },
  { '@lsp.mod.attribute', { link = 'Special' } },
  { '@lsp.type.decorator.rust', { link = 'TSNamespace' } },
  { '@lsp.type.enum', { link = 'Type' } },
  { '@lsp.type.interface', { link = 'Type' } },
  { '@lsp.type.keyword.rust', { link = 'TSKeyword' } },
  { '@lsp.type.macro.rust', { link = 'Function' } },
  { '@lsp.type.namespace', { link = 'TSNamespace' } },
  { '@lsp.type.selfTypeKeyword', { link = 'Type' } },
  { '@lsp.type.struct', { link = 'Type' } },
  { '@operator.try', { link = 'Special' } },
  { '@punctuation.bracket', { fg = colors.base0D } },
  { '@punctuation.special', { fg = colors.base0C } },
  { '@storageclass.rust', { link = 'TSKeyword' } },
  { '@variable', { fg = colors.base05 } },
  { '@variable.builtin', { fg = colors.base05, italic = true } },
  { 'CmpItemAbbr', { fg = colors.base03 } },
  { 'CmpItemAbbrDeprecated', { fg = colors.base03, italic = true } },
  { 'CmpItemAbbrMatch', { fg = colors.base05, bold = true } },
  { 'CmpItemAbbrMatchFuzzy', { fg = colors.base05, bold = true } },
  { 'CmpItemKind', { fg = colors.base0C } },
  { 'CmpItemMenu', { fg = colors.base03 } },
  { 'Comment', { fg = colors.base03, italic = true } },
  { 'ConflictMarkerBegin', { bg = '#255c51' } },
  { 'ConflictMarkerCommonAncestorsHunk', { bg = '#51335a' } },
  { 'ConflictMarkerEnd', { bg='#254e71' } },
  { 'ConflictMarkerOurs', { bg = '#203833' } },
  { 'ConflictMarkerTheirs', { bg = '#243749' } },
  { 'CurSearch', { link = 'IncSearch' } },
  { 'CursorLineNr', { fg = colors.base04, bg = '#202020', bold = true } },
  { 'DiagnosticError', { fg = colors.base08, bg = colors.base01 } },
  { 'DiagnosticHint', { fg = colors.base0C, bg = colors.base01 } },
  { 'DiagnosticInfo', { fg = colors.base05, bg = colors.base01 } },
  { 'DiagnosticUnderlineWarn', { sp = colors.base0A, underline = true } },
  { 'DiagnosticWarn', { fg = colors.base0A, bg = colors.base01 } },
  { 'DiffAdd', { bg = '#334539' } },
  { 'DiffChange', { bg = '#454133' } },
  { 'DiffDelete', { bg = '#45333a', bold = true } },
  { 'DiffText', { bg = '#5f5d42', bold = true } },
  { 'GitSignsAdd', { fg = colors.base0B, bg = colors.base01 } },
  { 'GitSignsAddInline', { fg = colors.base00, bg = colors.base0B } },
  { 'GitSignsChange', { fg = colors.base0A, bg = colors.base01 } },
  { 'GitSignsDelete', { fg = colors.base08, bg = colors.base01 } },
  { 'GitSignsDeleteInline', { fg = colors.base00, bg = colors.base08 } },
  { 'IncSearch', { bg = '#45333a' } },
  { 'LineNr', { fg = colors.base04, bg = colors.base01 } },
  { 'MatchParen', { reverse = true } },
  { 'MatchParenCur', { bg = '#515151' } },
  { 'MatchWord', { bg = '#454545' } },
  { 'MatchWordCur', { bg = '#515151' } },
  { 'Search', { bg = '#454133' } },
  { 'SignColumn', { link = 'LineNr' } },
  { 'StatusLineDiagnosticError', { fg = onedark.black.gui, bg = onedark.red.gui } },
  { 'StatusLineDiagnosticHint', { fg = onedark.black.gui, bg = onedark.cyan.gui } },
  { 'StatusLineDiagnosticWarn', { fg = onedark.black.gui, bg = onedark.yellow.gui } },
  { 'Substitute', { bg = '#454133' } },
  { 'TerminalCurrentDirectory', { fg = colors.base09, bg = '#3E4452' } },
  { 'TroubleIndent', { fg = colors.base04 } },
  { 'Whitespace', { fg = colors.base02 } },
  { 'Yanked', { bg = '#134a28' } },
  { 'gitcommitComment', { link = 'Comment' } },
})
