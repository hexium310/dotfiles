local utils = require('plugins/utils')
local lsp_utils = require('plugins/lsp/utils')

local default = {
  capabilities = require('cmp_nvim_lsp').default_capabilities(),
  commands = {
    RenameFile = {
      function ()
        require('plugins/lsp/utils').rename_file()
      end,
    },
  },
  handlers = {
    ['textDocument/hover'] = vim.lsp.with(vim.lsp.handlers.hover, {
      border = 'rounded',
      focusable = false,
    }),
    ['textDocument/signatureHelp'] = vim.lsp.with(vim.lsp.handlers.signature_help, {
      border = 'rounded',
      silent = true,
      focusable = false,
    }),
  },
  on_attach = function (client, bufnr)
    local goto_opts = {
      float = lsp_utils.float_opts,
    }
    local maps = {
      { { 'n', 'i' }, '<F2>', vim.lsp.buf.rename },
      { 'n', '<F3>', vim.lsp.buf.code_action },
      { 'n', 'K', require('plugins/lsp/utils').hover },
      { 'n', 'gf', vim.lsp.buf.definition },
      { 'n', ']c', function () vim.diagnostic.goto_next(goto_opts) end },
      { 'n', '[c', function () vim.diagnostic.goto_prev(goto_opts) end },
      { 'n', '<C-d>', function () require('plugins/lsp/utils').send_key('<C-d>', bufnr) end },
      { 'n', '<C-u>', function () require('plugins/lsp/utils').send_key('<C-u>', bufnr) end },
      { 'n', '<C-f>', function () require('plugins/lsp/utils').send_key('<C-f>', bufnr) end },
      { 'n', '<C-b>', function () require('plugins/lsp/utils').send_key('<C-b>', bufnr) end },
    }

    utils.set_keymaps(maps, {
      buffer = bufnr,
      silent = true,
    })

    if client.server_capabilities.inlayHintProvider then
      vim.lsp.inlay_hint.enable(true)
    end

    vim.api.nvim_create_augroup('LspConfig', { clear = false })

    utils.create_unique_autocmd({ 'CursorHold' }, {
      group = 'LspConfig',
      buffer = bufnr,
      desc = 'Open diagnostic float',
      callback = function ()
        vim.diagnostic.open_float(vim.tbl_extend('error', {
          scope = 'cursor',
        }, lsp_utils.float_opts))
      end,
    })
  end,
}

return default
