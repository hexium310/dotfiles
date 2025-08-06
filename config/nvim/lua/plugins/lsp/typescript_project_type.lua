local M = {}

---@param bufnr string | integer
---@return ('deno' | 'node' | nil), string | nil
function M.detect(bufnr)
  local node_root = vim.fs.root(bufnr, { 'package.json' })

  if node_root then
    return 'node', node_root
  end

  local deno_root = vim.fs.root(bufnr, { 'deno.json', 'deno.jsonc', '.git' })

  if deno_root then
    return 'deno', deno_root
  end

  return nil, nil
end

return M
