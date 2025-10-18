local function insert_to_eol(text)
  local start_row = vim.fn.getpos('v')[2]
  local end_row = vim.fn.getpos('.')[2]
  for row = math.min(start_row, end_row), math.max(start_row, end_row) do
    vim.api.nvim_buf_set_text(0, row - 1, -1, row - 1, -1, { text })
  end
end

vim.keymap.set({ 'n', 'x' }, '<Space>;', function () insert_to_eol(';') end, {})
vim.keymap.set({ 'n', 'x' }, '<Space>,', function () insert_to_eol(',') end, {})
