local plugins = {
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
    'junegunn/fzf.vim',
    cond = function ()
      return vim.fn.executable('fzf')
    end,
    -- event = { 'VeryLazy' },
    dependencies = {
      {
        dir = vim.fs.normalize('$FZF_HOME'),
        -- Don't update by dein because fzf is managed with a plugin manager for Zsh
        pin = true,
      },
    },
    init = function ()
      vim.fn['plugin#fzf#set_variables']()
      vim.fn['plugin#fzf#set_maps']()
      vim.fn['plugin#fzf#set_commands']()
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
    config = function ()
      require('plugins/toggleterm')
    end,
  },
  {
    'tpope/vim-fugitive',
    -- event = { 'VeryLazy' },
    init = function ()
      vim.fn['plugin#fugitive#set_maps']()
    end,
  },
  {
    'lewis6991/gitsigns.nvim',
    event = { 'BufRead' },
    config = function ()
      require('plugins/gitsigns')
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
    'nvim-lua/plenary.nvim',
    lazy = true,
  },
  {
    'notomo/lreload.nvim',
    ft = { 'lua' },
    config = function ()
      -- require('lreload').enable('plugins')
    end,
  },
  {
    'hexium310/diffmt.nvim',
    cmd = { 'Diffmt' },
    config = function ()
      vim.api.nvim_create_user_command('Diffmt', require('diffmt').diff, {})
    end,
  },
}

return plugins
