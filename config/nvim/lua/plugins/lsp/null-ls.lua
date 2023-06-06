local utils = require('plugins/utils')
local lsp_utils = require('plugins/lsp/utils')
local diagnostic = require('plugins/lsp/diagnostic')
local general = require('plugins/lsp/servers').general
local null_ls = require('null-ls')

local M = {}

local config = vim.tbl_deep_extend('force', general, {
  diagnostics_format = '(#{c}) #{m}',
  sources = {
    null_ls.builtins.diagnostics.luacheck,
  },
  capabilities = require('cmp_nvim_lsp').default_capabilities(),
  on_attach = function (_, bufnr)
    local namespaces = vim.tbl_map(function (source)
      return require('null-ls/diagnostics').get_namespace(source.id)
    end, require('null-ls').get_sources())

    for _, namespace in ipairs(namespaces) do
      local goto_opts = {
        namespace = namespace,
        float = lsp_utils.float_opts,
      }
      local maps = {
        { 'n', ']a', function () vim.diagnostic.goto_next(goto_opts) end },
        { 'n', '[a', function () vim.diagnostic.goto_prev(goto_opts) end },
      }

      diagnostic.ignore_signs(namespace)
      utils.set_keymaps(maps, {
        buffer = bufnr,
        silent = true,
      })
    end
  end,
})

function M.setup()
  null_ls.setup(config)
end

return M
