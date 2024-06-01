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
        arrayIndex = 'Disable',
        semicolon = 'Disable',
      },
    },
  },
}

M.opts = opts

return M
