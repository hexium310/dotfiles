local lsp_utils = require('plugins/lsp/utils')
local default = require('plugins/lsp/servers/default')

local M = {}

local opts = {
  on_attach = function (client, bufnr)
    lsp_utils.set_document_formatting(client, false)
    default.on_attach(client, bufnr)
  end,
}

M.opts = opts

return M
