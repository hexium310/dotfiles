local plugins = {
  {
    'nvim-treesitter/nvim-treesitter',
    event = { 'BufRead' },
    dependencies = {
      'nvim-treesitter/nvim-treesitter-textobjects',
      'JoosepAlviste/nvim-ts-context-commentstring',
      'vim-matchup',
    },
    config = function ()
      require('plugins/treesitter')
    end,
  },
  {
    'nvim-treesitter/playground',
    ft = { 'query' },
    cmd = { 'TSPlaygroundToggle' },
    dependencies = {
      'nvim-treesitter',
    },
  },
}

return plugins
