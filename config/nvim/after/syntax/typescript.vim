" Extend yats.vim
syntax region typescriptClassTypeParameter matchgroup=typescriptTypeBrackets start="<" end=">" contains=typescriptTypeParameter nextgroup=typescriptClassBlock,typescriptClassExtends contained skipwhite skipnl
syntax cluster typescriptTopExpression add=typescriptVariable,typescriptConditional,typescriptRepeat

syntax match typescriptDotNotation /\./ nextgroup=typescriptProp,typescriptFuncCall skipnl
syntax match typescriptFuncCall /[a-zA-Z]\k*\ze\(<.*>\)\?(/ containedin=@typescriptStatement
highlight link typescriptFuncCall Function

syntax keyword typescriptImport import nextgroup=typescriptModuleAsterisk,typescriptModuleKeyword,typescriptModuleGroup skipwhite skipempty
syntax match typescriptModuleKeyword /\<\K\k*/ nextgroup=typescriptModuleAs,typescriptFrom,typescriptModuleComma contained skipwhite skipempty
syntax match typescriptModuleAsterisk /\*/ nextgroup=typescriptModuleKeyword,typescriptModuleAs,typescriptFrom contained skipwhite skipempty
syntax keyword typescriptModuleAs as nextgroup=typescriptModuleKeyword contained skipwhite skipempty
syntax keyword typescriptFrom from nextgroup=typescriptString contained skipwhite skipempty
syntax match typescriptModuleComma /,/ nextgroup=typescriptModuleKeyword,typescriptModuleAsterisk,typescriptModuleGroup contained skipwhite skipempty
syntax region typescriptModuleGroup matchgroup=typescriptModuleBraces start=/{/ end=/}/ contains=typescriptModuleKeyword,typescriptModuleComma,typescriptModuleAs,typescriptComment nextgroup=typescriptFrom contained skipwhite skipempty



syntax clear typescriptArrowFuncDef
syntax match   typescriptArrowFuncDef          contained /({\_[^}]*}\(:\_[^)]\)\?)\s*=>/
 \ contains=typescriptArrowFuncArg,typescriptArrowFunc
 \ nextgroup=@typescriptExpression,typescriptBlock
 \ skipwhite skipempty

" Change to \_[^()] from \_[^)]
syntax match   typescriptArrowFuncDef          contained /(\(\_s*[a-zA-Z\$_\[]\_[^()]*\)*)\s*=>/
 \ contains=typescriptArrowFuncArg,typescriptArrowFunc
 \ nextgroup=@typescriptExpression,typescriptBlock
 \ skipwhite skipempty

syntax match   typescriptArrowFuncDef          contained /\K\k*\s*=>/
 \ contains=typescriptArrowFuncArg,typescriptArrowFunc
 \ nextgroup=@typescriptExpression,typescriptBlock
 \ skipwhite skipempty

syntax region  typescriptArrowFuncDef          contained start=/(\_[^)]*):/ end=/=>/
  \ contains=typescriptArrowFuncArg,typescriptArrowFunc,typescriptTypeAnnotation
  \ nextgroup=@typescriptExpression,typescriptBlock
  \ skipwhite skipempty keepend



highlight link typescriptClassName Function
highlight link typescriptClassTypeParameter Operator
highlight link typescriptClassHeritage Function
highlight link typescriptInterfaceTypeParameter Operator
highlight link typescriptInterfaceHeritage Type

highlight link typescriptImport Keyword
highlight link typescriptModuleAs Keyword
highlight link typescriptFrom Keyword
highlight link typescriptExport Keyword
highlight link typescriptModule Keyword
highlight link typescriptCastKeyword Keyword
highlight link typescriptIdentifier Constant
highlight link typescriptKeywordOp Keyword
highlight link typescriptOperator Keyword
highlight link typescriptForOperator Keyword
highlight link typescriptMessage Function
highlight link typescriptBranch Keyword
highlight link typescriptDefault Keyword
highlight link typescriptStatementKeyword Keyword
highlight link typescriptTry Keyword
highlight link typescriptExceptions Keyword
highlight link typescriptDebugger Keyword
highlight link typescriptAmbientDeclaration Keyword
highlight link typescriptAbstract Keyword

highlight link typescriptClassStatic Keyword

highlight link typescriptMember Label

highlight link typescriptGlobal Constant

highlight link typescriptTypeBrackets Operator
highlight link typescriptTypeParameter Type
highlight link typescriptTypeReference Type
highlight link typescriptAliasDeclaration Function

highlight link typescriptArrayStaticMethod Function
highlight link typescriptDateStaticMethod Function
highlight link typescriptJSONStaticMethod Function
highlight link typescriptMathStaticMethod Function
highlight link typescriptNumberStaticMethod Function
highlight link typescriptObjectStaticMethod Function
highlight link typescriptPromiseStaticMethod Function
highlight link typescriptStringStaticMethod Function
highlight link typescriptSymbolStaticMethod Function

command! VimShowHlItem echo synIDattr(synID(line("."), col("."), 1), "name")
