require'nvim-treesitter.configs'.setup {
  ensure_installed = {
    "bash",
    "css",
    "javascript",
    "json",
    "query",
    "toml",
    "tsx",
    "typescript",
    "yaml",
  },
  indnet = {
    enable = true,
  },
  highlight = {
    enable = true,
  },
}
