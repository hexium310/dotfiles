local default = require('plugins.lsp.servers.default')

local M = {}

local opts = {
  on_attach = function (client, bufnr)
    vim.keymap.del('n', 'K', { buffer = bufnr })
    default.on_attach(client,bufnr)
  end
}

M.opts = opts

return M
