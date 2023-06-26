-- lua_add {{{
require('plugins/utils').set_keymaps({
  { 'n', 'sa', '<Plug>(operator-surround-append)' },
  { 'n', 'sd', '<Plug>(operator-surround-delete)' },
  { 'n', 'sr', '<Plug>(operator-surround-replace)' },
}, { remap = true, silent = true })
-- }}}
