require('nvim-eslint').setup({
  settings = {
    format = {
      enable = true,
    },
    options = {
      flags = {
        'unstable_native_nodejs_ts_config',
      },
    },
  },
})
