-- lua_add {{{
vim.g.wordmotion_nomap = 1
require('plugins/utils').set_keymaps({
  { 'n', 'w', '<Plug>WordMotion_w' },
  { 'n', 'b', '<Plug>WordMotion_b' },
  { 'n', 'e', '<Plug>WordMotion_e' },
  { 'n', 'ge', '<Plug>WordMotion_ge' },
}, { remap = true })
-- }}}
