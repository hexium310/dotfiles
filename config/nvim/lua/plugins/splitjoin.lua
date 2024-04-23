local gen_hook = require('mini.splitjoin').gen_hook
local curly = {
  brackets = {
    '%b()',
    '%b[]',
    '%b{}',
  },
}

local add_comma_curly = gen_hook.add_trailing_separator(curly)
local del_comma_curly = gen_hook.del_trailing_separator(curly)
local pad_curly = gen_hook.pad_brackets(curly)

require('mini.splitjoin').setup({
  mappings = {
    toggle = 'gs',
    split = 'gS',
    join = 'gJ',
  },
  split = {
    hooks_post = {
      add_comma_curly,
    },
  },
  join  = {
    hooks_post = {
      del_comma_curly,
      pad_curly,
    },
  },
})
