vim.lsp.stop_client(vim.lsp.get_active_clients())

require('mason').setup({
  ui = {
    border = 'rounded',
    keymaps = {
      apply_language_filter = '<C-g>',
    },
  },
})

require('mason-lspconfig').setup({
  ensure_installed = {
    'eslint',
    'jsonls',
    'lua_ls',
    'rust_analyzer',
    'tailwindcss',
    'tsserver',
    'vimls',
    'yamlls',
  },
})

require('plugins/lsp/diagnostic').setup()
require('plugins/lsp/null-ls').setup()
require('plugins/lsp/servers').setup()
