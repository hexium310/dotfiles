vim.filetype.add({
  extension = {
    zunit = 'zsh',
  },
})

local augroup = vim.api.nvim_create_augroup('init_filetype', {})
vim.api.nvim_create_autocmd('FileType', {
  pattern = { 'gitcommit', 'gitrebase' },
  callback = function ()
    vim.bo.bufhidden = 'delete'
  end
})
