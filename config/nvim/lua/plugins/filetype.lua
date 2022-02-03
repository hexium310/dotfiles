require('filetype').setup({
  overrides = {
    complex = {
      ['queries/.+/.+%.scm'] = 'query',
    },
  },
})
