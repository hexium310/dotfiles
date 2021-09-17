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

  for _, lang in pairs(servers:installed_servers()) do
    config.lspconfig(lang)
  end

  vim.cmd([[
    augroup lspconfig
      autocmd!
      autocmd CursorHold * lua vim.diagnostic.show_position_diagnostics({ border = 'rounded', focusable = false })
      autocmd CursorHoldI * lua require('plugins/lsp/utils').signature_help()
    augroup END
  ]])
end

return init
