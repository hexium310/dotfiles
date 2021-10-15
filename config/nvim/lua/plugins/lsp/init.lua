local function init()
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

  local config = require('plugins/lsp/config')
  config.completion()
  config.diagnostic()
  config.null_ls()
  config.lspconfig()

  vim.cmd([[
    augroup lspconfig
      autocmd!
      autocmd CursorHold * lua vim.diagnostic.show_position_diagnostics({ border = 'rounded', focusable = false, source = 'always' })
      autocmd CursorHoldI * lua if not require('cmp').visible() then require('plugins/lsp/utils').signature_help() end
    augroup END
  ]])
end

return init
