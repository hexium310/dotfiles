local ensure_installed = {
  'emmet_language_server',
  'vimls',
}

require('mason-lspconfig').setup({
  ensure_installed,
})
