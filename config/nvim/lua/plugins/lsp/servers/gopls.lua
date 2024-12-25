local M = {}

local opts = {
  settings = {
    gopls = {
      semanticTokens = true,
      hints = {
        assignVariableTypes = true,
      },
    },
  },
}

M.opts = opts

return M
