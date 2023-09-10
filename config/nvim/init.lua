local dein_dir = vim.fs.joinpath(vim.fn.stdpath('data'), 'dein')
local dein_core = vim.fs.joinpath(dein_dir, 'repos/github.com/Shougo/dein.vim')

-- if vim.fn.isdirectory(dein_core) ~= 1 then
--   local result = vim.system({
--     'git',
--     'clone',
--     '--depth=1',
--     'https://github.com/Shougo/dein.vim',
--     dein_core,
--   }):wait()
--
--   if result.code ~= 0 then
--     vim.notify_once('Cloning dein.vim failed: ' .. result.stderr, vim.log.levels.ERROR)
--   end
-- end

vim.opt.runtimepath:prepend(vim.fs.joinpath(vim.fn.stdpath('data'), 'lazy/lazy.nvim'))
require('plugins/lazy')

vim.cmd.runtime({ 'userautoload/*.lua', bang = true })
