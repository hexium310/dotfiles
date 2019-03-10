command! GitCommit execute s:Commit()

function! s:Commit()
  silent execute '!GIT_EDITOR=false git commit'
  execute 'split .git/COMMIT_EDITMSG'
endfunction

function! s:CommitFinish()
  execute '!GIT_EDITOR=false git commit --cleanup=strip -F .git/COMMIT_EDITMSG'
endfunction

augroup gitcommit
  autocmd!
  autocmd VimLeavePre,BufDelete,BufLeave COMMIT_EDITMSG execute s:CommitFinish()
augroup END
