" Extends yats.vim

" ?
syntax region typescriptClassTypeParameter matchgroup=typescriptTypeBrackets start="<" end=">" contains=typescriptTypeParameter nextgroup=typescriptClassBlock,typescriptClassExtends contained skipwhite skipnl
syntax cluster typescriptTopExpression add=typescriptVariable,typescriptConditional,typescriptRepeat

" Enables calling function syntax highlight
syntax match typescriptDotNotation /\./ nextgroup=typescriptProp,typescriptFuncCall skipnl
syntax match typescriptFuncCall /\zs[A-Za-z_$][0-9A-Za-z_$]*\ze\(<\_.\{-}>\)\?(/ containedin=typescriptIdentifierName,typescriptParamImpl nextgroup=typescriptFuncCallArg,typescriptTypeArguments
highlight link typescriptFuncCall Function

" Added method in ES2019
syntax keyword typescriptObjectStaticMethod contained fromEntries nextgroup=typescriptFuncCallArg

" Enables import/export syntax highlight
syntax keyword typescriptImport import nextgroup=typescriptModuleAsterisk,typescriptModuleKeyword,typescriptModuleGroup skipwhite skipempty
syntax keyword typescriptExport export nextgroup=typescriptModuleAsterisk,typescriptModuleKeyword,typescriptModuleGroup,@typescriptStatement skipwhite skipempty
syntax match typescriptModuleKeyword /\<\K\k*/ nextgroup=typescriptModuleAs,typescriptFrom,typescriptModuleComma contained skipwhite skipempty
syntax match typescriptModuleAsterisk /\*/ nextgroup=typescriptModuleKeyword,typescriptModuleAs,typescriptFrom contained skipwhite skipempty
syntax keyword typescriptModuleAs as nextgroup=typescriptModuleKeyword contained skipwhite skipempty
syntax keyword typescriptFrom from nextgroup=typescriptString contained skipwhite skipempty
syntax match typescriptModuleComma /,/ nextgroup=typescriptModuleKeyword,typescriptModuleAsterisk,typescriptModuleGroup contained skipwhite skipempty
syntax region typescriptModuleGroup matchgroup=typescriptModuleBraces start=/{/ end=/}/ contains=typescriptModuleKeyword,typescriptModuleComma,typescriptModuleAs,@typescriptComments nextgroup=typescriptFrom contained skipwhite skipempty
highlight link typescriptImport Keyword
highlight link typescriptExport Keyword
highlight link typescriptFrom Keyword
highlight link typescriptModuleAs Keyword
highlight link typescriptModule Keyword

" Enables `extends` highlight in <> or () or other (nextgroup=typescriptConstraint)
" Enables types highlight in indexed access operator (K of T[K]) (containedin=typescriptTypeBracket)
syntax match typescriptTypeReference /\K\k*\(\.\K\k*\)*/
  \ containedin=typescriptTypeBracket
  \ nextgroup=typescriptTypeArguments,@typescriptTypeOperator,typescriptUserDefinedType,typescriptConstraint
  \ skipwhite contained skipempty

" Changes tuple-type syntax matchgroup (matchgroup=typescript=TypeBraces)
syntax region typescriptTupleType matchgroup=typescriptTypeBraces
 \ start=/\[/ end=/\]/
 \ contains=@typescriptType
 \ contained skipwhite oneline

syntax region   typescriptArrowFuncDef          contained start=/(\_s*{/ end=/}\_s*)\_s*=>/
  \ contains=typescriptArrowFuncArg,typescriptArrowFunc,typescriptTypeAnnotation
  \ nextgroup=@typescriptExpression,typescriptBlock
  \ skipwhite skipempty keepend

" Resets highlight link
highlight link typescriptClassName Function
highlight link typescriptClassTypeParameter Operator
highlight link typescriptClassHeritage Function
highlight link typescriptInterfaceTypeParameter Operator
highlight link typescriptInterfaceHeritage Type
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
highlight link typescriptMember Identifier
highlight link typescriptObjectLabel Identifier
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
highlight link typescriptEndColons None
highlight link typescriptVariable Keyword
highlight link typescriptRepeat Keyword
highlight link typescriptConstraint Special
highlight link typescriptConstructorType Special
highlight link typescriptUserDefinedType Special
highlight link typescriptTypeQuery Special
highlight link typescriptUnion Special
highlight link typescriptTypeAnnotation Special
highlight link typescriptMappedIn Special
highlight link typescriptDefaultParam Special
highlight link typescriptReadonlyArrayKeyword Special
highlight link typescriptOptionalMark Special
highlight link typescriptCall Constant

command! VimShowHlItem echo join(reverse(map(synstack(line('.'), col('.')), { _, id -> synIDattr(id, 'name') })), ' ')
