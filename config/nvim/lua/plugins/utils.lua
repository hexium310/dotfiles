local M = {}

M.diagnostic = {
  signs = {
    text = {
      ERROR = vim.fn.nr2char(0xea87),
      WARN = vim.fn.nr2char(0xea6c),
      INFO = vim.fn.nr2char(0xea74),
      HINT = vim.fn.nr2char(0xeb32),
    },
  },
}

local function autocmd_exists(opts)
  local autocmds = vim.api.nvim_get_autocmds(opts)
  return not vim.tbl_isempty(autocmds)
end

function M.set_keymaps(mappings, opts)
  for _, v in ipairs(mappings) do
    local modes = v[1]
    local lhs = v[2]
    local rhs = v[3]

    vim.keymap.set(modes, lhs, rhs, vim.tbl_extend('keep', v[4] or {}, opts))
  end
end

function M.set_highlights(highlighs)
  for _, v in ipairs(highlighs) do
    local name = v[1]
    local args = v[2]

    vim.api.nvim_set_hl(0, name, args)
  end
end

function M.create_unique_autocmd(event, opts)
  local pattern = opts.buffer and ('<buffer=%s>'):format(opts.buffer) or opts.pattern

  if autocmd_exists({ event = event, group = opts.group, pattern = pattern }) then
    return
  end

  vim.api.nvim_create_autocmd(event, opts)
end

return M
