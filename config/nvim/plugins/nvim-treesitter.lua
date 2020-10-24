require'nvim-treesitter.configs'.setup {
  ensure_installed = {
    "query",
    "typescript",
    "tsx",
  },
  indnet = {
    enable = true,
  },
  highlight = {
    enable = true,
  },
}
