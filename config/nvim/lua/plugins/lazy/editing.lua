local plugins = {
  {
    'AndrewRadev/splitjoin.vim',
    keys = {
      { 'gJ' },
      { 'gS' },
    },
    init = function ()
      vim.g.splitjoin_html_attributes_bracket_on_new_line = 1
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
    'nishigori/increment-activator',
    keys = {
      { '<C-a>' },
      { '<C-x>' },
    },
  },
  {
    'tversteeg/registers.nvim',
    commit = 'f354159',
    pin = true,
    keys = {
      { '"', mode = { 'n', 'v' } },
      { '<C-r>', mode = 'i' },
    },
    init = function ()
      vim.g.registers_window_min_height = 15
      vim.g.registers_window_border = 'single'
    end,
  },
  {
    'windwp/nvim-autopairs',
    event = { 'InsertEnter' },
    config = function ()
      require('plugins/autopairs')
    end,
  },
  {
    'numToStr/Comment.nvim',
    keys = {
      { 'gb', mode = { 'n', 'v' } },
      { 'gc', mode = { 'n', 'v' } },
    },
    config = function ()
      require('plugins/comment')
    end,
  },
  {
    'hrsh7th/nvim-cmp',
    event = { 'InsertEnter' },
    dependencies = {
      'hrsh7th/vim-vsnip',
      'hrsh7th/cmp-buffer',
      'hrsh7th/cmp-path',
    },
    config = function ()
      require('plugins/cmp')
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
    'rhysd/vim-operator-surround',
    keys = {
      { 'sa', '<Plug>(operator-surround-append)', silent = true },
      { 'sd', '<Plug>(operator-surround-delete)', silent = true },
      { 'sr', '<Plug>(operator-surround-replace)', silent = true },
    },
    dependencies = {
      'vim-operator-user',
    },
  },
  {
    'emonkak/vim-operator-sort',
    keys = {
      { 'so', '<Plug>(operator-sort)', mode = { 'n', 'v' } },
    },
    dependencies = {
      'vim-operator-user',
    }
  },
  {
    'rhysd/vim-textobj-anyblock',
    event = { 'BufRead' },
    -- keys = {
    --   { 'ib', mode = { 'x', 'o' } },
    --   { 'ab', mode = { 'x', 'o' } },
    -- },
    dependencies = {
      'vim-textobj-user',
    },
  },
  {
    'kana/vim-textobj-indent',
    event = { 'BufRead' },
    -- keys = {
    --   { 'ii', mode = { 'x', 'o' } },
    --   { 'ai', mode = { 'x', 'o' } },
    --   { 'iI', mode = { 'x', 'o' } },
    --   { 'aI', mode = { 'x', 'o' } },
    -- },
    dependencies = {
      'vim-textobj-user',
    },
  },
  {
    'kana/vim-textobj-line',
    event = { 'BufRead' },
    -- keys = {
    --   { 'il', mode = { 'x', 'o' } },
    --   { 'al', mode = { 'x', 'o' } },
    -- },
    dependencies = {
      'vim-textobj-user',
    },
  },
  {
    'kana/vim-textobj-entire',
    event = { 'BufRead' },
    -- keys = {
    --   { 'ie', mode = { 'x', 'o' } },
    --   { 'ae', mode = { 'x', 'o' } },
    -- },
    dependencies = {
      'vim-textobj-user',
    },
  },
  {
    'sgur/vim-textobj-parameter',
    event = { 'BufRead' },
    -- keys = {
    --   { 'i,', mode = { 'x', 'o' } },
    --   { 'a,', mode = { 'x', 'o' } },
    -- },
    dependencies = {
      'vim-textobj-user',
    },
  },
  {
    'Julian/vim-textobj-variable-segment',
    event = { 'BufRead' },
    -- keys = {
    --   { 'iv', mode = { 'x', 'o' } },
    --   { 'av', mode = { 'x', 'o' } },
    -- },
    dependencies = {
      'vim-textobj-user',
    },
  },
  {
    'glts/vim-textobj-comment',
    event = { 'BufRead' },
    -- keys = {
    --   { 'ic', mode = { 'x', 'o' } },
    --   { 'ac', mode = { 'x', 'o' } },
    -- },
    dependencies = {
      'vim-textobj-user',
    },
  },
}

return plugins
