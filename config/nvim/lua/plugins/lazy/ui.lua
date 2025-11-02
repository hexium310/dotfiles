return {
  {
    'RRethy/nvim-base16',
    lazy = true,
  },
  {
    'ii14/onedark.nvim',
    lazy = true,
  },
  {
   'nvim-lualine/lualine.nvim',
    event = { 'VimEnter' },
    config = function ()
      require('plugins.lualine')
    end,
  },
  {
     'luukvbaal/statuscol.nvim',
    branch = '0.10',
    event = { 'BufRead' },
    config = function ()
      require('plugins.statuscol')
    end,
  },
  {
    'andymass/vim-matchup',
    event = { 'BufRead' },
    init = function ()
      vim.g.matchup_matchparen_offscreen = {}
    end,
  },
  {
    'kevinhwang91/nvim-bqf',
    ft = { 'qf' },
    config = function ()
      require('plugins.bqf')
    end,
  },
  {
    'shellRaining/hlchunk.nvim',
    event = { 'BufReadPre', 'BufNewFile' },
    config = function()
      require('plugins.hlchunk')
    end,
  },
}
