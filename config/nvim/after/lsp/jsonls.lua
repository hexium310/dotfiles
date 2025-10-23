local json_schemas = require('plugins.lsp.json_schemas')

---@type vim.lsp.Config
return {
  -- https://archlinux.org/packages/extra/any/vscode-json-languageserver/
  cmd = {
    'vscode-json-languageserver',
    '--stdio',
  },
  settings = {
    json = {
      schemas = json_schemas.decode().schemas,
    },
  },
}
