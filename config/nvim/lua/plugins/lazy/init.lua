if vim.g.lazy_did_setup then
  return {}
end

require('lazy').setup('plugins/lazy', {
  ui = {
    border = 'single',
  },
  diff = {
    cmd = 'browser',
  },
  lockfile = vim.fs.joinpath(vim.fn.stdpath('cache'), 'lazy-lock.json'),
})

return {}
