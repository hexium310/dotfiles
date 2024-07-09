-- The builtin clipboard detection is slow because executable() is called many times.
if vim.fn.empty(vim.env.TMUX) ~= 1 then
  vim.g.clipboard = {
    name = 'tmux',
    copy = {
      ['+'] = { 'tmux', 'load-buffer', '-w', '-' },
      ['*'] = { 'tmux', 'load-buffer', '-w', '-' },
    },
    paste = {
      ['+'] = { 'tmux', 'save-buffer', '-' },
      ['*'] = { 'tmux', 'save-buffer', '-' },
    },
    chache_enabled = 0,
  }

  return
end

if vim.fn.has('wsl') then
  vim.g.clipboard = {
    name = 'wsl',
    copy = {
      ['+'] = { 'clip.exe' },
      ['*'] = { 'clip.exe' },
    },
    -- Ignores getting the clipboard content because the way of using powershell.exe or win32yank.exe is slow.
    paste = {
      ['+'] = function () return { "" } end,
      ['*'] = function () return { "" } end,
    },
    chache_enabled = 0,
  }

  return
end
