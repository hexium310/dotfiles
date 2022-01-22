local utils = require('plugins/utils')

local function init()
  local gitsigns = require('gitsigns')
  local actions = require('gitsigns.actions')

  gitsigns.setup({
    signs = {
      changedelete = {
        numhl = 'GitSignsChangeDeleteNr',
      },
    },
    signcolumn = false,
    numhl = true,
    preview_config = {
      border = 'double',
      -- Display a hunk preview over a LSP popup (zindex=50)
      zindex = 60,
    },
    on_attach = function (bufnr)
      local maps = {
        { 'n', ']g', actions.next_hunk },
        { 'n', '[g', actions.prev_hunk },
        { 'n', '<Space>h', actions.preview_hunk },
        { 'n', '<Space>gr', actions.reset_hunk },
        { 'v', '<Space>gr', function () gitsigns.reset_hunk({ vim.fn.line('.'), vim.fn.line('v') }) end },
        { { 'o', 'x' }, 'ah', actions.select_hunk },
        { { 'o', 'x' }, 'ih', actions.select_hunk },
      }

      utils.set_keymaps(maps, {
        buffer = bufnr,
        silent = true,
      })
    end,
  })

  vim.cmd([[
    command! ToggleDeletedLine lua require('gitsigns').toggle_deleted()
  ]])
end

return init
