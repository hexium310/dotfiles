local M = {}

local opts = {
  settings = {
    Lua = {
      hover = {
        previewFields = 100,
      },
      completion = {
        callSnippet = 'Replace',
        keywordSnippet = 'Replace',
      },
      hint = {
        enable = true,
      },
    },
  },
}

M.opts = opts

M.setup = function ()
  require('neodev').setup(opts)
end

return M