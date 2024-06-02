require('lazydev').setup({
  library = {
    'luvit-meta/library',
  },
  enabled = function(root_dir)
    if vim.g.lazydev_enabled ~= nil then
      return vim.g.lazydev_enabled
    end
    return vim.fs.find('lua', { limit = math.huge, type = 'directory', path = root_dir }) and true or false
  end,
})
