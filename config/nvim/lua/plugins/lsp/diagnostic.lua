local M = {}

local namespaces_without_signs = {}

local function reset_diagnostic()
  vim.diagnostic.reset(nil, 0)
  package.loaded['vim.diagnostic'] = nil
  vim.diagnostic = require('vim.diagnostic')
end

local function show_higest_severity_signs()
  local orig_signs_handler = vim.diagnostic.handlers.signs
  local signs_namespace = vim.api.nvim_create_namespace('highest_severity_diagnostic_signs')

  vim.diagnostic.handlers.signs = {
    show = function (_, bufnr, _, opts)
      local diagnostics = vim.diagnostic.get(bufnr)
      diagnostics = vim.tbl_filter(function (diagnostic)
        return not vim.tbl_contains(namespaces_without_signs, diagnostic.namespace)
      end, diagnostics)

      local max_severity_per_line = {}
      for _, diagnostic in pairs(diagnostics) do
        local max = max_severity_per_line[diagnostic.lnum]
        if not max or diagnostic.severity < max.severity then
          max_severity_per_line[diagnostic.lnum] = diagnostic
        end
      end

      local filtered_diagnostics = vim.tbl_values(max_severity_per_line)
      orig_signs_handler.show(signs_namespace, bufnr, filtered_diagnostics, opts)
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
    signs = true,
  })

  show_higest_severity_signs()
end

return M
