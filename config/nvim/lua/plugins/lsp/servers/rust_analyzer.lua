local default = require('plugins.lsp.servers.default')

local M = {}

local opts = {
  settings = {
    ['rust-analyzer'] = {
      rustfmt = {
        extraArgs = { '+nightly' },
      },
      check = {
        command = 'clippy',
      },
      cargo = {
        features = "all",
      },
    },
  },
}

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
      default_settings = opts.settings,
    }),
  }
end

return M
