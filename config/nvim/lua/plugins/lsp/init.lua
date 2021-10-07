local function init()
  local config = require('plugins/lsp/config')
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
  config.completion()
  config.diagnostic()
  config.null_ls()

  vim.lsp.stop_client(vim.lsp.get_active_clients())
  for _, lang in ipairs(vim.list_extend({ 'null-ls' }, servers:installed_servers())) do
    config.lspconfig(lang)
  end

  vim.cmd([[
    augroup lspconfig
      autocmd!
      autocmd CursorHold * lua vim.diagnostic.show_position_diagnostics({ border = 'rounded', focusable = false, source = 'always' })
      autocmd CursorHoldI * lua require('plugins/lsp/utils').signature_help()
    augroup END
  ]])
end

return init
