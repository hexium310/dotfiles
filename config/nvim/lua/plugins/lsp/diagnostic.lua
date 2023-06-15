local M = {}

local namespaces_without_signs = {}

local function reset_diagnostic()
  vim.diagnostic.reset(nil, 0)
  package.loaded['vim.diagnostic'] = nil
  vim.diagnostic = require('vim.diagnostic')
end

local function separate_and_sort(diagnostics)
  local severity = vim.diagnostic.severity
  local linter = {
    [severity.ERROR] = {},
    [severity.WARN] = {},
    [severity.INFO] = {},
    [severity.HINT] = {},
  }
  local lsp = {
    [severity.ERROR] = {},
    [severity.WARN] = {},
    [severity.INFO] = {},
    [severity.HINT] = {},
  }

  for _, diagnostic in ipairs(diagnostics) do
    local list = vim.tbl_contains(namespaces_without_signs, diagnostic.namespace) and linter or lsp
    table.insert(list[diagnostic.severity], diagnostic)
  end

  return linter, lsp
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

local function show_higest_severity_underline()
  local orig_underline_handler = vim.diagnostic.handlers.underline
  local underline_namespace = vim.api.nvim_create_namespace('highest_severity_diagnostic_underline')

  vim.diagnostic.handlers.underline = {
    show = function (_, bufnr, _, opts)
      local diagnostics = vim.diagnostic.get(bufnr)
      local linter, lsp = separate_and_sort(diagnostics)
      diagnostics = vim.fn.flattennew({ vim.tbl_values(vim.fn.reverse(linter)), vim.tbl_values(vim.fn.reverse(lsp)) })

      orig_underline_handler.show(underline_namespace, bufnr, diagnostics, opts)
    end,
    hide = function (_, bufnr)
      orig_underline_handler.hide(underline_namespace, bufnr)
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
  show_higest_severity_underline()
end

return M
