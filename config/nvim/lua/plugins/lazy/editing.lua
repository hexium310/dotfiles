return {
  {
    'Wansmer/treesj',
    keys = {
      { 'gJ', function () require('treesj').join() end },
      { 'gS', function () require('treesj').split() end },
      { 'gs', function () require('treesj').toggle() end },
    },
    config = function()
      require('plugins.treesj')
    end,
  },
  {
    'chaoren/vim-wordmotion',
    keys = {
      { 'w', '<Plug>WordMotion_w', mode = 'n', remap = true },
      { 'b', '<Plug>WordMotion_b', mode = 'n', remap = true },
      { 'e', '<Plug>WordMotion_e', mode = 'n', remap = true },
      { 'ge', '<Plug>WordMotion_ge', mode = 'n', remap = true },
    },
    init = function ()
      vim.g.wordmotion_nomap = true
    end,
  },
  {
    'rhysd/clever-f.vim',
    keys = {
      { 'f' },
      { 'F' },
      { 't' },
      { 'T' },
      { ';', '<Plug>(clever-f-repeat-forward)' },
      { ',', '<Plug>(clever-f-repeat-back)' },
    },
    init = function ()
      vim.g.clever_f_use_migemo = 1
      vim.g.clever_f_fix_key_direction = 1
    end,
  },
  {
    'monaqa/dial.nvim',
    keys = {
      { '<C-a>', function () require('dial.map').manipulate('increment', 'normal') end },
      { '<C-x>', function () require('dial.map').manipulate('decrement', 'normal') end },
      { 'g<C-a>', function () require('dial.map').manipulate('increment', 'gnormal') end },
      { 'g<C-x>', function () require('dial.map').manipulate('decrement', 'gnormal') end },
      { '<C-a>', function () require('dial.map').manipulate('increment', 'visual') end, mode = 'v' },
      { '<C-x>', function () require('dial.map').manipulate('decrement', 'visual') end, mode = 'v' },
      { 'g<C-a>', function () require('dial.map').manipulate('increment', 'gvisual') end, mode = 'v' },
      { 'g<C-x>', function () require('dial.map').manipulate('decrement', 'gvisual') end, mode = 'v' },
    },
    config = function ()
      require('plugins.dial')
    end,
  },
  {
    'tversteeg/registers.nvim',
    keys = {
      { '"', mode = { 'n', 'x' } },
      { '<C-r>', mode = 'i' },
    },
    config = function ()
      require('plugins.registers')
    end,
  },
  {
    'windwp/nvim-autopairs',
    event = { 'InsertEnter' },
    config = function ()
      require('plugins.autopairs')
    end,
  },
  {
    'ysmb-wtsg/in-and-out.nvim',
    keys = {
      { '<C-c>', function () require('in-and-out').in_and_out() end, mode = 'i' },
    },
  },
  {
    'hrsh7th/nvim-cmp',
    event = { 'InsertEnter' },
    dependencies = {
      'hrsh7th/cmp-buffer',
      'hrsh7th/cmp-path',
    },
    config = function ()
      require('plugins.cmp')
    end,
  },
  {
    'kana/vim-operator-user',
    lazy = true,
  },
  {
    'kana/vim-textobj-user',
    lazy = true,
  },
  {
    'kana/vim-operator-replace',
    keys = {
      { 'R', '<Plug>(operator-replace)' },
    },
    dependencies = {
      'vim-operator-user',
    }
  },
  {
    'emonkak/vim-operator-sort',
    keys = {
      { 'so', '<Plug>(operator-sort)', mode = { 'n', 'v' } },
    },
    dependencies = {
      'vim-operator-user',
    },
    submodules = false,
  },
  {
    'rhysd/vim-textobj-anyblock',
    keys = {
      { 'ib', mode = { 'x', 'o' } },
      { 'ab', mode = { 'x', 'o' } },
    },
    dependencies = {
      'vim-textobj-user',
    },
  },
  {
    'kana/vim-textobj-indent',
    keys = {
      { 'ii', mode = { 'x', 'o' } },
      { 'ai', mode = { 'x', 'o' } },
      { 'iI', mode = { 'x', 'o' } },
      { 'aI', mode = { 'x', 'o' } },
    },
    dependencies = {
      'vim-textobj-user',
    },
  },
  {
    'kana/vim-textobj-line',
    keys = {
      { 'il', mode = { 'x', 'o' } },
      { 'al', mode = { 'x', 'o' } },
    },
    dependencies = {
      'vim-textobj-user',
    },
  },
  {
    'kana/vim-textobj-entire',
    keys = {
      { 'ie', mode = { 'x', 'o' } },
      { 'ae', mode = { 'x', 'o' } },
    },
    dependencies = {
      'vim-textobj-user',
    },
  },
  {
    'sgur/vim-textobj-parameter',
    keys = {
      { 'i,', mode = { 'x', 'o' } },
      { 'a,', mode = { 'x', 'o' } },
    },
    dependencies = {
      'vim-textobj-user',
    },
  },
  {
    'Julian/vim-textobj-variable-segment',
    keys = {
      { 'iv', mode = { 'x', 'o' } },
      { 'av', mode = { 'x', 'o' } },
    },
    dependencies = {
      'vim-textobj-user',
    },
  },
  {
    'glts/vim-textobj-comment',
    keys = {
      { 'ic', mode = { 'x', 'o' } },
      { 'ac', mode = { 'x', 'o' } },
    },
    dependencies = {
      'vim-textobj-user',
    },
  },
  {
    'kylechui/nvim-surround',
    keys = { 'sa', 'ssa', 'sA', 'sAA', 'sd', 'sr', 'sR' },
    config = function ()
      require('plugins.surround')
    end
  },
}
