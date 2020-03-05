syntax keyword vimConst const skipwhite nextgroup=vimVar,vimFuncVar
syntax match vimCmdSep "[:|]\+" skipwhite nextgroup=vimAddress,vimAutoCmd,vimEcho,vimIsCommand,vimExtCmd,vimFilter,vimLet,vimMap,vimMark,vimSet,vimSyntax,vimUserCmd,vimConst
syntax cluster vimAugroupList add=vimConst
syntax cluster vimFuncBodyList add=vimConst
syntax cluster vimUserCmdList add=vimConst
highlight link vimConst vimCommand

syntax match vimColorscheme "\<colo\%[rscheme]\>" contains=vimCommand skipwhite nextgroup=vimColorschemeTheme
syntax match vimColorschemeTheme /[\-[:alnum:]]\+/ contained skipwhite
highlight link vimColorschemeTheme None

highlight link vimHighlight Keyword
highlight link vimCommand Keyword
highlight link vimSynType Keyword
highlight link vimHiTerm Special
highlight link vimArgsFunction Function
