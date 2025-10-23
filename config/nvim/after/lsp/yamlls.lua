---@type vim.lsp.Config
return {
  settings = {
    yaml = {
      schemas = {
        kubernetes = {
          '/*manifests*/**/*.yaml',
          '/*manifests*/*.yaml',
        },
      }
    },
  },
}
