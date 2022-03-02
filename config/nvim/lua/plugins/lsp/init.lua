vim.lsp.stop_client(vim.lsp.get_active_clients())

require('plugins/lsp/install').install({
  'eslint',
  'jsonls',
  'rust_analyzer',
  'sumneko_lua',
  'tailwindcss',
  'tsserver',
  'vimls',
  'yamlls',
})

require('plugins/lsp/diagnostic').setup()
require('plugins/lsp/null-ls').setup()
require('plugins/lsp/servers').setup()
