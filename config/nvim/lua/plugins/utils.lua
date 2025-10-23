local namespaces_without_signs = {}

local M = {
  diagnostic = {
    signs = {
      text = {
        ERROR = vim.fn.nr2char(0xea87),
        WARN = vim.fn.nr2char(0xea6c),
        INFO = vim.fn.nr2char(0xea74),
        HINT = vim.fn.nr2char(0xeb32),
      },
    },
    float = {
      opts = {
        border = 'rounded',
        focusable = false,
        source = 'always',
      },
    },
    ---@param namespace number
    ignore_signs = function (namespace)
      if not vim.tbl_contains(namespaces_without_signs, namespace) then
        table.insert(namespaces_without_signs, namespace)
      end
    end,
  },
  lsp = {
    floating = {
      send_key = function (command, bufnr)
        bufnr = bufnr or vim.api.nvim_get_current_buf()
        local lsp_floating_window = vim.F.npcall(vim.api.nvim_buf_get_var, bufnr, 'lsp_floating_preview')

        local window = (function ()
          if lsp_floating_window and vim.api.nvim_win_is_valid(lsp_floating_window) and
            vim.api.nvim_win_get_height(lsp_floating_window) < vim.api.nvim_buf_line_count(vim.api.nvim_win_get_buf(lsp_floating_window)) then
            return lsp_floating_window
          end

          return vim.api.nvim_get_current_win()
        end)()

        vim.api.nvim_win_call(window, function ()
          local escaped_command = vim.api.nvim_replace_termcodes(command, true, false, true)
          vim.cmd(('normal! %s'):format(escaped_command))
        end)
      end
    },
    rename_file = function ()
      local filename = vim.fn.expand('%')

      vim.ui.input({
        prompt = 'New Filename',
        default = filename,
        completion = 'file',
      }, function (new_filename)
          if new_filename == nil then
            return
          end

          vim.lsp.util.rename(filename, new_filename)
        end)
    end,
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
