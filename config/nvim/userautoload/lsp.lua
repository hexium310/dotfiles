local default_config = require('plugins.lsp.config')

local servers = {
  'biome',
  'denols',
  'docker_language_server',
  'dockerls',
  'eslint',
  'gopls',
  'jsonls',
  'lua_ls',
  -- `rust-analyzer` is used by rustaceanvim instead
  -- 'rust_analyzer',
  'taplo',
  'ts_ls',
  'yamlls',
}

vim.lsp.config('*', default_config)
vim.lsp.enable(servers)

vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('plugins.lsp', {}),
  callback = function (args)
    local client = assert(vim.lsp.get_client_by_id(args.data.client_id))
    default_config.on_attach(client, args.buf)
  end
})
