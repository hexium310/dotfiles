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
})

return {}
