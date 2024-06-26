local utils = require('plugins.utils')

local gitsigns = require('gitsigns')
local actions = require('gitsigns.actions')

gitsigns.setup({
  signs = {
    delete       = { text = '┃' },
    topdelete    = { text = '┃' },
    changedelete = { text = '┃' },
  },
  preview_config = {
    border = 'double',
    -- Display a hunk preview over a LSP popup (zindex=50)
    zindex = 60,
  },
  on_attach = function (bufnr)
    local maps = {
      { 'n', ']g', function () actions.nav_hunk('next', { navigation_message = false }) end },
      { 'n', '[g', function () actions.nav_hunk('prev', { navigation_message = false }) end },
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

vim.api.nvim_create_user_command('ToggleDeletedLine', gitsigns.toggle_deleted, {})
vim.api.nvim_create_user_command('ToggleLineBlame', gitsigns.toggle_current_line_blame, {})
