local lazy_path = vim.fs.joinpath(vim.fn.stdpath('data'), 'lazy/lazy.nvim')

if vim.fn.isdirectory(lazy_path) ~= 1 then
  local result = vim.system({
    'git',
    'clone',
    '--filter=blob:none',
    'https://github.com/folke/lazy.nvim',
    lazy_path,
  }):wait()

  if result.code ~= 0 then
    vim.notify_once('Cloning lazy.nvim failed: ' .. result.stderr, vim.log.levels.ERROR)
  end
end

vim.opt.runtimepath:prepend(lazy_path)
require('plugins.lazy')

vim.cmd.runtime({ 'userautoload/*.lua', bang = true })
