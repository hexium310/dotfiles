local utils = require('plugins.utils')

local function disable_cursor_hold()
  vim.opt.eventignorewin:append('CursorHold')

  vim.api.nvim_create_augroup('LspConfig.DisableCursorHold', { clear = true })

  vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI', 'BufHidden', 'InsertCharPre' }, {
    group = 'LspConfig.DisableCursorHold',
    buffer = vim.api.nvim_get_current_buf(),
    once = true,
    desc = 'Prevent floating window with diagnostic opening while one with hover information is opened',
    callback = function ()
      vim.opt.eventignorewin:remove('CursorHold')
    end
  })
end

local default = {
  capabilities = require('cmp_nvim_lsp').default_capabilities(),
  commands = {
    RenameFile = {
      function ()
        require('plugins.utils').lsp.rename_file()
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
    local maps = {
      { { 'n', 'i' }, '<F2>', vim.lsp.buf.rename },
      { 'n', '<F3>', vim.lsp.buf.code_action },
      { 'n', 'K', function ()
        vim.lsp.buf.hover(utils.diagnostic.float.opts)
        -- Stops a hover floating window from being hidden by a diagnostic floating window on CursorHold
        disable_cursor_hold()
      end },
      { 'n', 'gf', vim.lsp.buf.definition },
      { 'n', '<C-d>', function () require('plugins.utils').lsp.floating.send_key('<C-d>', bufnr) end },
      { 'n', '<C-u>', function () require('plugins.utils').lsp.floating.send_key('<C-u>', bufnr) end },
      { 'n', '<C-f>', function () require('plugins.utils').lsp.floating.send_key('<C-f>', bufnr) end },
      { 'n', '<C-b>', function () require('plugins.utils').lsp.floating.send_key('<C-b>', bufnr) end },
      { 'n', '<F8>', vim.lsp.buf.format },
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
        }, utils.diagnostic.float.opts))
      end,
    })
  end,
}

return default
