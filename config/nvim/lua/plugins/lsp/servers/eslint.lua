local utils = require('plugins.utils')
local diagnostic = require('plugins.lsp.diagnostic')

local M = {}

local opts = {
  on_attach = function (client, bufnr)
    local namespace = vim.lsp.diagnostic.get_namespace(client.id)
    local jump_opts = {
      diagnostic = {
        namespace = namespace,
      },
      float = utils.diagnostic.float.opts,
    }
    local maps = {
      { 'n', ']a', function () vim.diagnostic.jump(vim.tbl_deep_extend('force', jump_opts, { count = 1 })) end },
      { 'n', '[a', function () vim.diagnostic.jump(vim.tbl_deep_extend('force', jump_opts, { count = -1 })) end },
      { 'n', '<F8>', function () vim.lsp.buf.format({
        async = true,
        filter = function (c)
          return c.name ~= 'ts_ls'
        end,
      }) end },
    }

    diagnostic.ignore_signs(namespace)
    utils.set_keymaps(maps, {
      buffer = bufnr,
      silent = true,
    })
  end,
  settings = {
    format = {
      enable = true,
    },
  },
}

M.opts = opts

return M
