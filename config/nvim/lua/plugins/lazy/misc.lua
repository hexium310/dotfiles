return {
  {
    'folke/lazy.nvim',
  },
  {
    'qpkorr/vim-bufkill',
    event = { 'CmdlineEnter' },
    init = function ()
      vim.keymap.set('ca', 'bd', 'BD')
    end,
  },
  {
    'ibhagwan/fzf-lua',
    cmd = {
      'FzfLua',
      'Rg',
    },
    keys = {
      '<C-p>',
      '<Space>f',
      '<Space><C-m>',
      '<Space>e',
      '<Space>r',
    },
    config = function ()
      require('plugins.fzf')
    end,
  },
  {
    'akinsho/nvim-toggleterm.lua',
    cmd = {
      'ToggleTerm',
      'TermExec',
    },
    keys = {
      { '<C-t>', mode = { 'n', 'i' } },
    },
    dependencies = {
      {
        'notomo/waitevent.nvim',
        event = { 'TermOpen' },
        config = function ()
          require('plugins.waitevent')
        end,
      },
    },
    config = function ()
      require('plugins.toggleterm')
    end,
  },
  {
    'tpope/vim-fugitive',
    event = { 'VeryLazy' },
    init = function ()
      require('plugins.fugitive')
    end,
  },
  {
    'lewis6991/gitsigns.nvim',
    event = { 'BufRead' },
    config = function ()
      require('plugins.gitsigns')
    end,
  },
  {
    'rhysd/conflict-marker.vim',
    event = { 'BufRead' },
    init = function ()
      vim.g.conflict_marker_enable_mappings = 0
      vim.g.conflict_marker_highlight_group = ''
      vim.g.conflict_marker_begin = '^<<<<<<< .*$'
      vim.g.conflict_marker_end   = '^>>>>>>> .*$'
      vim.g.conflict_marker_common_ancestors = '^||||||| .*$'
      vim.keymap.set('n', ']f', '<Plug>(conflict-marker-next-hunk)')
      vim.keymap.set('n', '[f', '<Plug>(conflict-marker-prev-hunk)')
    end,
  },
  {
    'notomo/lreload.nvim',
    ft = { 'lua' },
    config = function ()
      require('lreload').enable('plugins')
    end,
  },
  {
    'hexium310/diffmt.nvim',
    cmd = { 'Diffmt' },
    config = function ()
      vim.api.nvim_create_user_command('Diffmt', require('diffmt').diff, {})
    end,
  },
  {
    'stevearc/dressing.nvim',
    event = { 'BufRead' },
    config = function ()
      require('plugins.dressing')
    end
  },
  {
    'j-hui/fidget.nvim',
    config = function ()
      require('plugins.fidget')
    end,
  },
  {
    'stevearc/oil.nvim',
    event = { 'BufRead' },
    keys = {
      { '<Space>o', function () require('oil').toggle_float() end },
    },
    config = function ()
      require('plugins.oil')
    end,
  },
  {
    'nvim-tree/nvim-web-devicons',
    lazy = true,
    module = true,
  },
}
