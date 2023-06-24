local function toggle_status_window()
  if vim.fn.FugitiveGitDir() == '' then
    return
  end

  local status_window = vim.iter(vim.fn.getwininfo()):find(function (v)
    return vim.tbl_contains(vim.tbl_keys(v.variables), 'fugitive_status')
  end)

  if status_window == nil then
    vim.cmd.Git()
    return
  end

  vim.api.nvim_win_close(status_window.winid, false)
end

vim.keymap.set('n', '<C-g>', toggle_status_window, { silent = true })
vim.keymap.set('n', '<Space>gd', vim.cmd.Gdiff, { silent = true })
