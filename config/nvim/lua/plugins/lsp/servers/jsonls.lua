local lsp_utils = require('plugins.lsp.utils')
local default = require('plugins.lsp.servers.default')
local json_schemas = require('plugins.lsp.json_schemas')

local M = {}

local opts = {
  on_attach = function (client, bufnr)
    lsp_utils.set_document_formatting(client, false)
    default.on_attach(client, bufnr)
  end,
  settings = {
    json = {
      schemas = json_schemas.decode().schemas,
    },
  },
}

M.opts = opts

M.setup = function ()
  json_schemas.setup()
end

return M
