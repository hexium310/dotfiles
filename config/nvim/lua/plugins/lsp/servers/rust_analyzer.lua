local default = require('plugins/lsp/servers/default')

local opts = {
  server = vim.tbl_deep_extend('force', default, {
    cmd = function ()
      local mason_registry = require('mason-registry')
      local mason_core = require('mason-core.path')
      local bin = mason_registry.is_installed('rust-analyzer') and mason_core.bin_prefix('rust-analyzer') or 'rust-analyzer'
      return {
        bin,
        '--log-file',
        vim.fn.tempname() .. '-rust-analyzer.log',
      }
    end,
    capabilities = require('cmp_nvim_lsp').default_capabilities(),
  }),
}

vim.g.rustaceanvim = opts
