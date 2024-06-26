return {
  {
    'neovim/nvim-lspconfig',
    event = { 'BufRead' },
    dependencies = {
      {
        'williamboman/mason.nvim',
        cmd = { 'Mason' },
        config = function ()
          require('plugins.mason')
        end,
      },
      {
        'williamboman/mason-lspconfig.nvim',
      },
      {
        'ray-x/lsp_signature.nvim',
        config = function ()
          require('plugins.lsp.signature')
        end,
      },
      {
        'hrsh7th/cmp-nvim-lsp',
        module = true,
      },
    },
    config = function ()
      require('plugins.lsp')
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
    config = function ()
      require('plugins.lsp.servers.rust_analyzer').setup()
    end
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
