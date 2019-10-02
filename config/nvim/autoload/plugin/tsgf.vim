function! plugin#tsgf#findFile()
  const cfile = expand('<cfile>')

  if stridx(cfile, '.') == 0
    normal! gf

    return
  endif

  const resolvedPaths = plugin#tsgf#resolvePath(plugin#tsgf#getPathAliases())
  const extensions = ['.ts', '.tsx']

  for path in resolvedPaths
    if isdirectory(path)
      let withIndex = path . '/index'

      for extension in extensions
        let withExtension = withIndex . extension

        if filereadable(withExtension)
          execute(':edit ' . withExtension)

          return
        endif
      endfor
    elseif filereadable(path)
      execute(':edit ' . path)

      return
    else
      for extension in extensions
        let withExtension = path . extension

        if filereadable(withExtension)
          execute(':edit ' . withExtension)

          return
        endif
      endfor
    endif
  endfor
endfunction

function! plugin#tsgf#readTsconfig()
  const projectRootPath = finddir('.git/..', expand('%:p:h') . ';')
  const tsconfig = (projectRootPath ? projectRootPath : getcwd()) . '/tsconfig.json'
  if filereadable(tsconfig)
    return json_decode(readfile(tsconfig))
  endif

  return {}
endfunction

function! plugin#tsgf#getPathAliases()
  const tsconfig = plugin#tsgf#readTsconfig()

  if tsconfig == {}
    return {}
  endif

  const compilerOptions = get(tsconfig, 'compilerOptions', { 'paths': {} })
  const paths = get(compilerOptions, 'paths')

  return paths
endfunction

function! plugin#tsgf#removeWildcard(value)
  return substitute(a:value, '\v(.*)\*', '\1', '')
endfunction

function! plugin#tsgf#resolvePath(paths)
  const cfile = expand('<cfile>')

  for [key, value] in items(a:paths)
    let resolvedPaths = map(value, { -> substitute(cfile, plugin#tsgf#removeWildcard(key), plugin#tsgf#removeWildcard(v:val), '') })

    for resolved in resolvedPaths
      if stridx(resolved, cfile) >= 0
        return resolvedPaths
      endif
    endfor
  endfor

  return []
endfunction
