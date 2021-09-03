local function init()
  local disables = {
    'bash',
    'css',
    'javascript',
    'tsx',
    'typescript',
  }

  require'nvim-treesitter.configs'.setup {
    ensure_installed = {
      'bash',
      'css',
      'javascript',
      'json',
      'lua',
      'query',
      'toml',
      'tsx',
      'typescript',
      'vim',
      'yaml',
    },
    indent = {
      disable = disables,
      enable = true,
    },
    highlight = {
      disable = disables,
      enable = true,
    },
  }
end

return init
