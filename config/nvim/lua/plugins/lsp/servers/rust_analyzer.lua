local default = require('plugins.lsp.servers.default')

local M = {}

local opts = {}

M.opts = opts

M.setup = function ()
  vim.g.rustaceanvim = {
    server = vim.tbl_deep_extend('force', default, opts, {
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
    }),
  }
end

return M
