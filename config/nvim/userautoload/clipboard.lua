-- The builtin clipboard detection is slow because executable() is called many times.

local function gclip_path()
  local linux = vim.fs.joinpath(vim.env.GOPATH, 'bin/gclip')
  local windows = vim.fs.joinpath(vim.env.USERPROFILE, 'go/bin/gclip')

  if vim.fn.executable(linux) == 1 then
    return linux
  end

  if vim.fn.executable(windows) == 1 then
    return windows
  end

  return nil
end

if vim.fn.has('wsl') then
  local gclip = gclip_path()
  -- gclip -copy blocks process
  local copy = { '/mnt/c/Windows/System32/clip.exe' }
  local paste = gclip ~= nil and { gclip, '-paste' } or function () return '' end

  vim.g.clipboard = {
    name = 'wsl',
    copy = {
      ['+'] = copy,
      ['*'] = copy,
    },
    paste = {
      ['+'] = paste,
      ['*'] = paste,
    },
    chache_enabled = 0,
  }

  return
end

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
