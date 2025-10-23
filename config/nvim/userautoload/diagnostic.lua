local utils = require('plugins.utils');

vim.diagnostic.config({
  virtual_text = false,
  severity_sort = true,
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = utils.diagnostic.signs.text.ERROR,
      [vim.diagnostic.severity.WARN] = utils.diagnostic.signs.text.WARN,
      [vim.diagnostic.severity.INFO] = utils.diagnostic.signs.text.INFO,
      [vim.diagnostic.severity.HINT] = utils.diagnostic.signs.text.HINT,
    },
  },
})
