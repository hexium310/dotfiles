local function init()
  local autopairs = require('nvim-autopairs')
  local rule = require('nvim-autopairs/rule')

  autopairs.setup({
    check_ts = true,
    map_c_w = true,
    ignored_next_char = '',
    fast_wrap = {
      chars = { '{', '[', '(', '"', "'", '`' },
    },
  })

  autopairs.add_rules({
    rule("'''", "'''", { 'toml' }),
    rule(' ', ' ')
      :with_pair(function (opts)
        local pair = opts.line:sub(opts.col - 1, opts.col)
        return vim.tbl_contains({ '()', '[]', '{}' }, pair)
      end),
  })
end

return init
