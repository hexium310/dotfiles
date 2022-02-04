local utils = require('plugins/lsp/utils')

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

local float_opts = vim.tbl_extend('error', {
  scope = 'cursor',
}, utils.float_opts)

vim.cmd(([[
  augroup lspconfig
    autocmd!
    autocmd CursorHold * lua vim.diagnostic.open_float(%s)
    autocmd CursorHoldI * lua if not require('cmp').visible() then require('plugins/lsp/utils').signature_help() end
  augroup END
]]):format(utils.table_to_string(float_opts)))
