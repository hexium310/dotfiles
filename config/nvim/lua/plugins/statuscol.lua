local builtin = require('statuscol.builtin')

require('statuscol').setup({
  ft_ignore = {
    'toggleterm',
    'fugitive',
    'DressingInput',
  },
  segments = {
    {
      text = {
        builtin.foldfunc,
      },
    },
    {
      sign = {
        name = {
          'Diagnostic',
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
        name = {
          'GitSigns'
        },
        maxwidth = 1,
        colwidth = 1,
      },
    },
  },
})
