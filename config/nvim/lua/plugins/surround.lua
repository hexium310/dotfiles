require('nvim-surround').setup({
  keymaps = {
    normal = 'sa',
    normal_cur = 'ssa',
    normal_line = 'sA',
    normal_cur_line = 'sAA',
    delete = 'sd',
    change = 'sr',
    change_line = 'sR',
  },
  move_cursor = false,
})
