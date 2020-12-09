-- Call manually `require'toggleterm'.__set_highlights()` because VimEnter has
-- already triggered when `require'toggleterm.setup {}` that call it is called.
require'toggleterm'.__set_highlights(-30)

require'toggleterm'.setup {
  size = 15,
  open_mapping = [[<C-t>]],
  shade_filetypes = {},
  shade_terminals = true,
  persist_size = true,
  direction = "horizontal"
}
