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
    command! -nargs=0 RenameFile lua require('plugins/lsp/utils').rename_file(); vim.fn['lightline#update']()

    augroup lspconfig
      autocmd!
      autocmd CursorHold * lua vim.lsp.diagnostic.show_position_diagnostics({ border = 'rounded', focusable = false })
      autocmd CursorHoldI * lua vim.lsp.buf.signature_help()
    augroup END
  ]])
end

return init
