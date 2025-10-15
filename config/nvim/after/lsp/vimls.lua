local default_config = require('plugins.lsp.config')

return {
  on_attach = function (client, bufnr)
    default_config.on_attach(client, bufnr)
    vim.keymap.del('n', 'K', { buffer = bufnr })
  end,
}
