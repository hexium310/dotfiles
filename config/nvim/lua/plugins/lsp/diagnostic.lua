local lsp_utils = require('plugins.lsp.utils')
local utils = require('plugins.utils');

local M = {}

local namespaces_without_signs = {}

local function reset_diagnostic()
  vim.diagnostic.reset(nil, 0)
  package.loaded['vim.diagnostic'] = nil
  vim.diagnostic = require('vim.diagnostic')
end

local function get_highest_severity(diagnostics)
  local max_severity_per_line = vim.iter(diagnostics):fold({}, function (max_severity, diagnostic)
    local max = max_severity[diagnostic.lnum]
    if not max or diagnostic.severity < max.severity then
      max_severity[diagnostic.lnum] = diagnostic
    end

    return max_severity
  end)

  return vim.tbl_values(max_severity_per_line)
end

local function set_sign_handler()
  local orig_signs_handler = vim.diagnostic.handlers.signs
  local signs_namespace = vim.api.nvim_create_namespace('highest_severity_diagnostic_signs')

  vim.diagnostic.handlers.signs = {
    show = function (_, bufnr, diagnostics, opts)
      orig_signs_handler.show(signs_namespace, bufnr, get_highest_severity(diagnostics), opts)
    end,
    hide = function (_, bufnr)
      orig_signs_handler.hide(signs_namespace, bufnr)
    end,
  }
end

---@param namespace number
function M.ignore_signs(namespace)
  if not vim.tbl_contains(namespaces_without_signs, namespace) then
    table.insert(namespaces_without_signs, namespace)
  end
end

function M.setup()
  reset_diagnostic()

  vim.diagnostic.config({
    virtual_text = false,
    signs = {
      text = {
        [vim.diagnostic.severity.ERROR] = utils.diagnostic.signs.text.ERROR,
        [vim.diagnostic.severity.WARN] = utils.diagnostic.signs.text.WARN,
        [vim.diagnostic.severity.INFO] = utils.diagnostic.signs.text.INFO,
        [vim.diagnostic.severity.HINT] = utils.diagnostic.signs.text.HINT,
      },
    },
    jump = {
      float = lsp_utils.float_opts,
    },
  })

  set_sign_handler()
end

return M
