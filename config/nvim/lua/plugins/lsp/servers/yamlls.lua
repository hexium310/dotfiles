local M = {}

local opts = {
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

M.opts = opts

return M
