local function init()
  require('gitsigns').setup({
    signs = {
      changedelete = {
        numhl = 'GitSignsChangeDeleteNr',
      },
    },
    signcolumn = false,
    numhl = true,
    keymaps = {
      noremap = true,
      ['n ]g'] = [[<Cmd>lua require('gitsigns.actions').next_hunk()<CR>]],
      ['n [g'] = [[<Cmd>lua require('gitsigns.actions').prev_hunk()<CR>]],
      ['n <Space>h'] = [[<Cmd>lua require('gitsigns.actions').preview_hunk()<CR>]],
      ['n <Space>gr'] = [[<Cmd>lua require('gitsigns.actions').reset_hunk()<CR>]],
      ['v <Space>gr'] = [[<Cmd>lua require('gitsigns').reset_hunk({ vim.fn.line('.'), vim.fn.line('v') })<CR>]],
      ['o ah'] = [[:<C-U>lua require('gitsigns.actions').select_hunk()<CR>]],
      ['x ah'] = [[:<C-U>lua require('gitsigns.actions').select_hunk()<CR>]],
      ['o ih'] = [[:<C-U>lua require('gitsigns.actions').select_hunk()<CR>]],
      ['x ih'] = [[:<C-U>lua require('gitsigns.actions').select_hunk()<CR>]],
    },
    preview_config = {
      border = 'double',
      -- Display a hunk preview over a LSP popup (zindex=50)
      zindex = 60,
    }
  })
end

return init
