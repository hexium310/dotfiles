local default_config = require('plugins.lsp.config')

local servers = {
  'biome',
  'denols',
  'docker_language_server',
  'dockerls',
  -- 'eslint',
  'gopls',
  'jsonls',
  'lua_ls',
  -- `rust-analyzer` is used by rustaceanvim instead
  -- 'rust_analyzer',
  'taplo',
  'tsgo',
  -- 'ts_ls',
  'yamlls',
}

vim.lsp.config('*', vim.tbl_deep_extend('force',  default_config, {
  before_init = function (_, config)
    local codesettings = require('codesettings')
    codesettings.with_local_settings(config.name, config)
  end,
}))
vim.lsp.enable(servers)

vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('plugins.lsp', {}),
  callback = function (args)
    local client = assert(vim.lsp.get_client_by_id(args.data.client_id))
    default_config.on_attach(client, args.buf)
  end
})
