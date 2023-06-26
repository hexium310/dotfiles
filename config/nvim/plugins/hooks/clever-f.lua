-- lua_add {{{
vim.g.clever_f_use_migemo = 1
vim.g.clever_f_fix_key_direction = 1
require('plugins/utils').set_keymaps({
  { 'n', ';', '<Plug>(clever-f-repeat-forward)' },
  { 'n', ',', '<Plug>(clever-f-repeat-back)' },
}, { remap = true })
-- }}}
