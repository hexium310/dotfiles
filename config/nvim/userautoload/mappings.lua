local set_keymaps = require('plugins.utils').set_keymaps

set_keymaps({
  { 'n', '<S-Up>', '<NOP>' },
  { 'n', '<S-Down>', '<NOP>' },
  { 'n', '<S-Left>', '<NOP>' },
  { 'n', '<S-Right>', '<NOP>' },
  { 'n', 's', '<NOP>' },
  { 'v', 'v', '$h' },
  { 'n', '<Esc><Esc>', vim.cmd.nohlsearch, { silent = true } },
  { { 'n', 'i' }, '<F1>', '<NOP>' },
  { 'n', 'q', '<NOP>' },
  { 'n', 'qq', 'q' },
  { 'n', 'q:', '<NOP>' },
  { '', '<C-q>', '<NOP>' },
  { 'ca', 'hc', 'helpclose' },
}, {})
