local function replace_bs(key)
  local utils = require('nvim-autopairs/utils')
  return string.gsub(key, utils.esc('<Right><BS>'), utils.esc('<Del>'))
end

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

  require('nvim-autopairs/completion/cmp').setup({
    auto_select = false,
  })

  autopairs.add_rules({
    rule("'''", "'''", { 'toml' }),
    rule(' ', ' ')
      :with_pair(function (opts)
        local pair = opts.line:sub(opts.col - 1, opts.col)
        return vim.tbl_contains({ '()', '[]', '{}' }, pair)
      end),
  })

  local original_autopairs_bs = autopairs.autopairs_bs
  autopairs.autopairs_bs = function (bufnr)
    return replace_bs(original_autopairs_bs(bufnr))
  end

  local original_autopairs_c_w = autopairs.autopairs_c_w
  autopairs.autopairs_c_w = function (bufnr)
    return replace_bs(original_autopairs_c_w(bufnr))
  end
end

return init
