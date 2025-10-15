return {
  {
    'nvim-treesitter/nvim-treesitter',
    branch = 'main',
    build = ':TSUpdate',
    lazy = false,
    dependencies = {
      {
        'nvim-treesitter/nvim-treesitter-textobjects',
        branch = 'main',
        lazy = false,
      },
      'vim-matchup',
    },
    config = function ()
      require('plugins.treesitter')
    end,
  },
}
