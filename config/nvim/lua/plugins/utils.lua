local M = {}

function M.set_keymaps(mappings, opts)
  for _, v in ipairs(mappings) do
    local modes = v[1]
    local lhs = v[2]
    local rhs = v[3]
    opts = vim.tbl_extend('keep', v[4] or {}, opts)

    vim.keymap.set(modes, lhs, rhs, opts)
  end
end

return M
