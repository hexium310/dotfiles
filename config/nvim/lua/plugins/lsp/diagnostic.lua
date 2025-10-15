local utils = require('plugins.utils');

local M = {}

local namespaces_without_signs = {}

local function reset_diagnostic()
  vim.diagnostic.reset(nil, 0)
  package.loaded['vim.diagnostic'] = nil
  vim.diagnostic = require('vim.diagnostic')
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
    severity_sort = true,
    signs = {
      text = {
        [vim.diagnostic.severity.ERROR] = utils.diagnostic.signs.text.ERROR,
        [vim.diagnostic.severity.WARN] = utils.diagnostic.signs.text.WARN,
        [vim.diagnostic.severity.INFO] = utils.diagnostic.signs.text.INFO,
        [vim.diagnostic.severity.HINT] = utils.diagnostic.signs.text.HINT,
      },
    },
  })
end

return M
