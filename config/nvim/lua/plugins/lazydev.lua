require('lazydev').setup({
  library = {
    'luvit-meta/library',
  },
  enabled = function(client)
    if vim.g.lazydev_enabled ~= nil then
      return vim.g.lazydev_enabled
    end
    return client.root_dir and vim.fs.find('lua', { limit = math.huge, type = 'directory', path = client.root_dir }) and true or false
  end,
})
