local M = {}

---@param bufnr string | integer
---@return ('deno' | 'node.tsgo' | 'node.typescript' | nil), string | nil
function M.detect(bufnr)
  local node_root = vim.fs.root(bufnr, { 'package.json' })

  if node_root then
    local tsgo = vim.fs.joinpath(node_root, 'node_modules/.bin', 'tsgo')

    if vim.fn.executable(tsgo) == 1 then
      return 'node.tsgo', node_root
    end

    return 'node.typescript', node_root
  end

  local deno_root = vim.fs.root(bufnr, { 'deno.json', 'deno.jsonc', '.git' })

  if deno_root then
    return 'deno', deno_root
  end

  return nil, nil
end

return M
