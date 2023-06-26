-- lua_add {{{
vim.g.conflict_marker_enable_mappings = 0
vim.g.conflict_marker_highlight_group = ''
vim.g.conflict_marker_begin = '^<<<<<<< .*$'
vim.g.conflict_marker_end   = '^>>>>>>> .*$'
vim.g.conflict_marker_common_ancestors = '^||||||| .*$'
require('plugins/utils').set_keymaps({
  { 'n', ']f', '<Plug>(conflict-marker-next-hunk)' },
  { 'n', '[f', '<Plug>(conflict-marker-prev-hunk)' },
}, { remap = true })
-- }}}
