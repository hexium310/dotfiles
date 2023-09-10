return {
  {
    'neovim/nvim-lspconfig',
    event = { 'BufRead' },
    dependencies = {
      {
        'williamboman/mason.nvim',
        config = function ()
          require('plugins/mason')
        end,
      },
      {
        'williamboman/mason-lspconfig.nvim',
      },
      {
        'jose-elias-alvarez/null-ls.nvim',
        dependencies = {
          {
            'plenary.nvim',
          },
        },
      },
      {
        'ray-x/lsp_signature.nvim',
        config = function ()
          require('plugins/lsp/signature')
        end,
      },
      {
        'hrsh7th/cmp-nvim-lsp',
      },
      {
        'folke/neodev.nvim',
      },
      {
        'simrat39/rust-tools.nvim',
      },
    },
    config = function ()
      require('plugins/lsp')
    end,
  },
  {
    'folke/trouble.nvim',
    cmd = { 'Trouble' },
    keys = {
      { '<Space>t', function () require('trouble').open() end, mode = 'n' },
    },
    config = function ()
      require('plugins/trouble')
    end,
  },
}
