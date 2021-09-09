local function init()
  local servers = require('plugins/lsp/install')
  servers.servers = {
    'json',
    'lua',
    'rust',
    'tailwindcss',
    'vim',
    'yaml',
    'typescript'
  }
  servers:install()
end

return init
