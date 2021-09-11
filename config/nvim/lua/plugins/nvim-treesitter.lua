local function init()
  local disables = {
    'bash',
    'css',
  }

  require('nvim-treesitter.configs').setup({
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
    playground = {
      disable = disables,
      enable = true,
    },
    query_linter ={
      enable = true,
    },
    textobjects = {
      select = {
        enable = true,
        lookahead = true,
        keymaps = {
          ['af'] = '@function.outer',
          ['if'] = '@function.inner',
        },
      },
      swap = {
        enable = true,
        swap_next = {
          ['<Space>pn'] = '@parameter.inner',
        },
        swap_previous = {
          ['<Space>pp'] = '@parameter.inner',
        },
      },
    },
  })
end

return init
