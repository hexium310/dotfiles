return {
  {
    'neovim/nvim-lspconfig',
  },
  {
    'williamboman/mason.nvim',
    cmd = { 'Mason' },
    config = function ()
      require('plugins.mason')
    end,
  },
  {
    'williamboman/mason-lspconfig.nvim',
    config = function ()
      require('plugins.mason_lspconfig')
    end,
  },
  {
    'ray-x/lsp_signature.nvim',
    config = function ()
      require('plugins.lsp.signature')
    end,
  },
  {
    'folke/trouble.nvim',
    cmd = { 'Trouble' },
    keys = {
      { '<Space>t', function () require('trouble').open({ mode = 'diagnostics', focus = true }) end, mode = 'n' },
    },
    config = function ()
      require('plugins.trouble')
    end,
  },
  {
    'mrcjkb/rustaceanvim',
    ft = { 'rust' },
  },
  {
    'folke/lazydev.nvim',
    ft = { 'lua' },
    config = function ()
      require('plugins.lazydev')
    end
  },
  {
    -- This will be installed for vim.uv typings and isn't vim plugin.
    'Bilal2453/luvit-meta',
    lazy = true,
  },
}
