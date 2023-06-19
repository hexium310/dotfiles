local plugins = {
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
      require('plugins/lualine')
    end,
  },
  {
     'luukvbaal/statuscol.nvim',
    event = { 'BufRead' },
    config = function ()
      require('plugins/statuscol')
    end,
  },
  {
    'RRethy/vim-hexokinase',
    cond = function ()
      return vim.fn.executable('go')
    end,
    build = 'make hexokinase',
    event = { 'BufRead' },
    init = function ()
      vim.g.Hexokinase_virtualText = '●'
      vim.g.Hexokinase_refreshEvents = { 'BufEnter', 'TextChanged', 'TextChangedI' }
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
      require('plugins/bqf')
    end,
  },
}

return plugins
