local default_config = require('plugins.lsp.config')

local servers = {
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
}

require('mason-lspconfig').setup({
  ensure_installed = servers,
  automatic_enable = false,
})

require('plugins.lsp.diagnostic').setup()

vim.lsp.config('*', default_config)
vim.lsp.enable(servers)
vim.lsp.enable('rust_analyzer', false)

vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('plugins.lsp', {}),
  callback = function (args)
    local client = assert(vim.lsp.get_client_by_id(args.data.client_id))
    default_config.on_attach(client, args.buf)
  end
})
