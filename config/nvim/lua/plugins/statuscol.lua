local builtin = require('statuscol.builtin')

require('statuscol').setup({
  ft_ignore = {
    'DressingInput',
    'Trouble',
    'fugitive',
    'lazy',
    'man',
    'oil',
    'toggleterm',
  },
  segments = {
    {
      text = {
        builtin.foldfunc,
      },
    },
    {
      sign = {
        namespace = {
          'diagnostic/signs',
        },
        maxwidth = 1,
        colwidth = 1,
        fillcharhl = 'SignColumn',
      },
    },
    {
      sign = {
        name = {
          ".*",
        },
        maxwidth = 2,
        colwidth = 1,
        auto = true,
      },
    },
    {
      text = {
        builtin.lnumfunc,
        ' ',
      },
    },
    {
      sign = {
        namespace = {
          'gitsign',
        },
        maxwidth = 1,
        colwidth = 1,
      },
    },
  },
})

-- `statuscolumn` is not set in a window after opening the fugitive summary window after startup
-- when lazy-loading statuscol.nvim on BufRead. Also, I don't know why, but `signcolumn` is set to `auto`.
vim.iter(vim.api.nvim_list_wins()):each(function (window_id)
  if vim.api.nvim_get_option_value('statuscolumn', { win = window_id }) == '' then
    vim.api.nvim_set_option_value('statuscolumn', '%!v:lua.StatusCol()', { win = window_id })
    vim.api.nvim_set_option_value('signcolumn', 'no', { win = window_id })
  end
end)
