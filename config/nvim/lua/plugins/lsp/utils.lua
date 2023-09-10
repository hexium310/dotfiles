local M = {}

M.float_opts = {
  border = 'rounded',
  focusable = false,
  source = 'always',
}

---@param tbl table
---@return table
function M.table_to_string(tbl)
  return vim.inspect(tbl, { newline = '' })
end

function M.disable_cursor_hold()
  vim.opt.eventignore:append('CursorHold')

  vim.api.nvim_create_augroup('LspConfig.DisableCursorHold', { clear = true })

  vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI', 'BufHidden', 'InsertCharPre' }, {
    group = 'LspConfig.DisableCursorHold',
    buffer = vim.api.nvim_get_current_buf(),
    once = true,
    desc = 'Prevent floating window with diagnostic opening while one with hover information is opened',
    callback = function ()
      vim.opt.eventignore:remove('CursorHold')
    end
  })
end

function M.hover()
  vim.lsp.buf.hover()
  M.disable_cursor_hold()
end

---@param command string
---@param bufnr number
function M.send_key(command, bufnr)
  bufnr = bufnr or vim.api.nvim_get_current_buf()
  local floating_window = vim.F.npcall(vim.api.nvim_buf_get_var, bufnr, 'lsp_floating_preview')
  local escaped_command = vim.api.nvim_replace_termcodes(command, true, false, true)
  if floating_window and vim.api.nvim_win_is_valid(floating_window) and
    vim.api.nvim_win_get_height(floating_window) < vim.api.nvim_buf_line_count(vim.api.nvim_win_get_buf(floating_window)) then
    vim.api.nvim_win_call(floating_window, function ()
      vim.cmd.normal(escaped_command)
    end)
    return
  end
  vim.api.nvim_feedkeys(escaped_command, 'n', true)
end

function M.rename_file()
  local filename = vim.fn.expand('%')
  local new_filename = vim.fn.input({
    prompt = 'New Filename: ',
    default = filename,
    completion = 'file',
  })

  if new_filename == '' then
    return
  end

  vim.lsp.util.rename(filename, new_filename)
end

---@param client table
---@param bool boolean
function M.set_document_formatting(client, bool)
  client.server_capabilities.documentFormattingProvider = bool
  client.server_capabilities.documentRangeFormattingProvider = bool
end

return M
