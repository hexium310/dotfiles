local utils = require('plugins.utils')

local languages = {
  'bash',
  'c',
  'comment',
  'cpp',
  'css',
  'dockerfile',
  'hcl',
  'html',
  'javascript',
  'json',
  'lua',
  'make',
  'markdown',
  'markdown_inline',
  'python',
  'query',
  'regex',
  'rust',
  'toml',
  'tsx',
  'typescript',
  'vim',
  'vimdoc',
  'yaml',
}

require('nvim-treesitter').install(languages)

require("nvim-treesitter-textobjects").setup({
  select = {
    selection_modes = {
      ['@function.outer'] = 'V',
    },
    include_surrounding_whitespace = function (opts)
      return opts.query_string:match('.+%.outer') ~= nil
    end,
  },
})

vim.api.nvim_create_autocmd('FileType', {
  pattern = languages,
  callback = function (args)
    vim.treesitter.start()

    vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"

    utils.set_keymaps({
      { { 'x', 'o' }, 'af', function() require('nvim-treesitter-textobjects.select').select_textobject('@function.outer', 'textobjects') end },
      { { 'x', 'o' }, 'if', function() require('nvim-treesitter-textobjects.select').select_textobject('@function.inner', 'textobjects') end },
      { { 'x', 'o' }, 'a.', function() require('nvim-treesitter-textobjects.select').select_textobject('@method.outer', 'textobjects') end },
      { { 'x', 'o' }, 'i.', function() require('nvim-treesitter-textobjects.select').select_textobject('@method.inner', 'textobjects') end },
      { { 'x', 'o' }, 'a,', function() require('nvim-treesitter-textobjects.select').select_textobject('@parameter.outer', 'textobjects') end },
      { { 'x', 'o' }, 'i,', function() require('nvim-treesitter-textobjects.select').select_textobject('@parameter.inner', 'textobjects') end },
      { 'n', '<Space>pn', function() require('nvim-treesitter-textobjects.swap').swap_next('@parameter.outer', 'textobjects') end },
      { 'n', '<Space>pp', function() require('nvim-treesitter-textobjects.swap').swap_next('@parameter.inner', 'textobjects') end },
    }, { buffer = args.buf })
  end
})
