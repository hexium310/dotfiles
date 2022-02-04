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
  vim.cmd([[
    setlocal eventignore+=CursorHold
    autocmd CursorMoved,CursorMovedI,BufHidden,InsertCharPre <buffer> ++once setlocal eventignore-=CursorHold
  ]])
end

function M.hover_or_open_vim_help()
  if vim.bo.filetype == 'vim' or vim.bo.filetype == 'help' then
    vim.cmd([[
      silent! execute 'h ' .. expand('<cword>')
    ]])
  else
    vim.lsp.buf.hover()
    require('plugins/lsp/utils').disable_cursor_hold()
  end
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
      vim.cmd(([[execute "normal %s"]]):format(escaped_command))
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

function M.signature_help()
  if vim.tbl_isempty(vim.tbl_filter(function (v) return v.resolved_capabilities.signature_help end, vim.lsp.buf_get_clients())) then
    return
  end
  vim.lsp.buf.signature_help()
end

---@param client table
---@param bool boolean
function M.set_document_formatting(client, bool)
  client.resolved_capabilities.document_formatting = bool
  client.resolved_capabilities.document_range_formatting = bool
end

function M.get_cmp_nvim_lsp_capabilities()
  local capabilities = vim.lsp.protocol.make_client_capabilities()
  return require('cmp_nvim_lsp').update_capabilities(capabilities)
end

return M
