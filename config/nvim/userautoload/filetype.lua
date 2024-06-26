vim.filetype.add({
  extension = {
    zunit = 'zsh',
  },
  pattern = {
    ['.*/config/git/config'] = 'gitconfig',
    ['.*%.gitconfig'] = 'gitconfig',
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
  pattern = { 'DressingInput' },
  callback = function ()
    local backspace = vim.opt.backspace
    vim.opt.backspace:append({ 'start' })

    vim.api.nvim_create_autocmd('WinLeave', {
      group = augroup,
      once = true,
      callback = function ()
        vim.opt.backspace = backspace
      end
    })
  end
})

vim.api.nvim_create_autocmd('FileType', {
  group = augroup,
  pattern = { 'oil' },
  callback = function ()
    vim.keymap.set('n', '<C-^>', '<NOP>', { buffer = 0 })
  end,
})
