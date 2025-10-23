local utils = require('plugins.utils')

---@type vim.lsp.Config
return {
  -- https://archlinux.org/packages/extra/any/eslint-language-server/
  cmd = {
    'eslint-language-server',
  },
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
      { { 'n', 'x' }, '<F8>', function () vim.lsp.buf.format({
        async = true,
        filter = function (c)
          return c.name ~= 'ts_ls'
        end,
      }) end },
    }

    utils.diagnostic.ignore_signs(namespace)
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
