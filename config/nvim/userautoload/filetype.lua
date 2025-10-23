vim.filetype.add({
  extension = {
    zunit = 'zsh',
  },
  pattern = {
    ['.*/config/git/config'] = 'gitconfig',
    ['.*%.gitconfig'] = 'gitconfig',
    ['compose.*%.yaml'] = 'yaml.docker-compose',
  },
})

local augroup = vim.api.nvim_create_augroup('init_filetype', {})
vim.api.nvim_create_autocmd('FileType', {
  group = augroup,
  pattern = { 'gitcommit', 'gitrebase' },
  callback = function ()
    vim.bo.bufhidden = 'delete'
  end
})

vim.api.nvim_create_autocmd('FileType', {
  group = augroup,
  pattern = { 'oil' },
  callback = function ()
    vim.keymap.set('n', '<C-^>', '<NOP>', { buffer = 0 })
  end,
})
