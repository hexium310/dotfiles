local json_schemas = require('plugins.lsp.json_schemas')

return {
  settings = {
    json = {
      schemas = json_schemas.decode().schemas,
    },
  },
}
