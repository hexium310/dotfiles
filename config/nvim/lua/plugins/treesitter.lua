local disables = {}

require('nvim-treesitter.configs').setup({
  ensure_installed = {
    'bash',
    'c',
    'comment',
    'cpp',
    'css',
    'dockerfile',
    'hcl',
    'html',
    'javascript',
    'json',
    'lua',
    'make',
    'markdown',
    'markdown_inline',
    'python',
    'query',
    'regex',
    'rust',
    'toml',
    'tsx',
    'typescript',
    'vim',
    'vimdoc',
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
      keymaps = {
        ['af'] = '@function.outer',
        ['if'] = '@function.inner',
        ['a.'] = '@method.outer',
        ['i.'] = '@method.inner',
      },
    },
    swap = {
      enable = true,
      swap_next = {
        ['<Space>pn'] = '@definition.field',
      },
      swap_previous = {
        ['<Space>pp'] = '@definition.field',
      },
    },
    include_surrounding_whitespace = true,
  },
  context_commentstring = {
    enable = true,
    disable = disables,
    config = {
      vim = '" %s',
    },
  },
  matchup = {
    enable = true,
    disable = disables,
  },
})
