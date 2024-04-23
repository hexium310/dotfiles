return {
  {
    'nvim-treesitter/nvim-treesitter',
    event = { 'BufRead' },
    cmd = {
      'TSUpdate',
      'TSInstallInfo',
      'TSUpdateInfo',
    },
    dependencies = {
      'nvim-treesitter/nvim-treesitter-textobjects',
      'vim-matchup',
    },
    config = function ()
      require('plugins.treesitter')
    end,
  },
}
