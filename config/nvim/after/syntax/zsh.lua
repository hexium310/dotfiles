vim.cmd([[
  syntax match zshIdetifier /[[:alnum:]_]\+/ contained containedin=zshSubst nextgroup=zshSubscript,zshParameterExpansionSuffix
  " Now, match in subscript
  " syntax match zshParameterExpansionPrefix /\%(+\|#\|\^\|=\|\~\)\+/ contained containedin=zshSubst nextgroup=zshIdetifier
  syntax match zshParameterExpansionSuffix /\%(:\?\%(-\|+\|:\?=\|?\)\|:\(#\||\|\*\|^\{1,2}\)\?\|#\{1,2}\|%\{1,2}\|\/\|\/\/\|:\/\)/ contained nextgroup=zshSubscript
  syntax match zshParameterFlag /(\%([#%@AabcCDefFiklnoOPqQtuUvVwWXz0p~mSBEMNR]\{-}\|[gjsZ_I]\(.\)\%(\1\@!.\{-}\)\?\1\|[lr]\(.\)\%(\2\@!.\{-}\)\?\2\%(\2\2\@!.\{-}\2\%\(\2\2\@!.\{-}\2\)\?\)\?\)\+)/ contained containedin=zshSubst nextgroup=zshIdetifier
  syntax region zshSubscript matchgroup=zshSubscriptBrackets start=/\[/ skip=/\\\]/ end=/\]/ contains=zshSubscriptFlag contained
  syntax match zshSubscriptFlag /(\%([wpfrRiIkKe]\{-}\|[snb]\(.\)\%(\1\@!.\{-}\)\?\1\|\)\+)/ contained
]])

local set_highlights = require('plugins.utils').set_highlights

set_highlights({
  { 'zshParameterFlag', { link = 'Macro' } },
  { 'zshSubscriptFlag', { link = 'Macro' } },
  { 'zshSubscriptBrackets', { link = 'zshSubst' } },
  { 'zshSubscript', { link = 'zshSubst' } },
  { 'zshIdetifier', { link = 'zshSubst' } },
  { 'zshParameterExpansionPrefix', { link = 'Macro' } },
  { 'zshParameterExpansionSuffix', { link = 'Macro' } },
})
