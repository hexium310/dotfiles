local set_keymaps = require('plugins/utils').set_keymaps

set_keymaps({
  { 'n', '<C-h>', '<C-w>h' },
  { 'n', '<C-j>', '<C-w>j' },
  { 'n', '<C-k>', '<C-w>k' },
  { 'n', '<C-l>', '<C-w>l' },
  { 'n', '<S-Up>', '<NOP>' },
  { 'n', '<S-Down>', '<NOP>' },
  { 'n', '<S-Left>', '<NOP>' },
  { 'n', '<S-Right>', '<NOP>' },
  { 'n', '[d', '[c' },
  { 'n', ']d', ']c' },
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
