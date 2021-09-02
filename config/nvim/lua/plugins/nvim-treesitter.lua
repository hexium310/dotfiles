local function init()
  require'nvim-treesitter.configs'.setup {
    ensure_installed = {
      -- "bash",
      -- "css",
      -- "javascript",
      -- "json",
      -- "query",
      -- "toml",
      "tsx",
      "typescript",
      -- "yaml",
    },
    indnet = {
      enable = false,
    },
    highlight = {
      enable = false,
    },
  }

  vim.cmd([[
    augroup nvim-treesitter
      autocmd!
      autocmd FileType vim :TSBufDisable highlight
    augroup END
  ]])
end

return init
