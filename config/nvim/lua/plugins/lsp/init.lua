vim.lsp.stop_client(vim.lsp.get_active_clients())

local augroup = vim.api.nvim_create_augroup('LspInstallerConfig', {})
vim.api.nvim_create_autocmd('FileType', {
  group = augroup,
  pattern = 'lsp-installer',
  callback = function ()
    vim.api.nvim_win_set_config(0, { border = "rounded" })
  end
})

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
