vim.lsp.stop_client(vim.lsp.get_clients())

require('lspconfig.ui.windows').default_options.border = 'rounded'

require('mason-lspconfig').setup({
  ensure_installed = {
    'denols',
    'emmet_language_server',
    'eslint',
    'gopls',
    'jsonls',
    'lua_ls',
    'rust_analyzer',
    'tailwindcss',
    'ts_ls',
    'vimls',
    'yamlls',
  },
})

require('plugins.lsp.diagnostic').setup()
require('plugins.lsp.lspconfig').setup()
