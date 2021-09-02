local function init()
  -- Call manually `require'toggleterm'.__set_highlights()` because VimEnter has
  -- already triggered when `require'toggleterm.setup {}` that call it is called.
  require'toggleterm'.__set_highlights(-30)

  require'toggleterm'.setup {
    size = 15,
    open_mapping = [[<C-t>]],
    start_in_insert = false,
    shade_filetypes = {},
    shade_terminals = true,
    persist_size = true,
    direction = "horizontal"
  }

  vim.cmd([[command! -nargs=* Yarn call luaeval('require"toggleterm".exec("yarn " .. _A, 4, 15)', <q-args>)]])
end

return init
