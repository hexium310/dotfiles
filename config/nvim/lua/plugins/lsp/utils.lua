local M = {}

function M.disable_cursor_hold()
  vim.cmd([[
    setlocal eventignore+=CursorHold
    autocmd CursorMoved,CursorMovedI,BufHidden,InsertCharPre <buffer> ++once setlocal eventignore-=CursorHold
  ]])
end

function M.hover_or_open_vim_help()
  if vim.bo.filetype == 'vim' or vim.bo.filetype == 'help' then
    vim.cmd([[
      silent! execute 'h '.expand('<cword>')
    ]])
  else
    vim.lsp.buf.hover()
    require('plugins/lsp/utils').disable_cursor_hold()
  end
end

function M.send_key(command, bufnr)
  bufnr = bufnr or vim.api.nvim_get_current_buf()
  local floating_window = vim.F.npcall(vim.api.nvim_buf_get_var, bufnr, 'lsp_floating_preview')
  local escaped_command = vim.api.nvim_replace_termcodes(command, true, false, true)
  if floating_window and vim.api.nvim_win_is_valid(floating_window) and
    vim.api.nvim_win_get_height(floating_window) < vim.api.nvim_buf_line_count(vim.api.nvim_win_get_buf(floating_window)) then
    vim.api.nvim_win_call(floating_window, function ()
      vim.cmd([[execute "normal ]] .. escaped_command .. [["]])
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

return M
