local M = {}

local opts = {
  settings = {
    deno = {
      suggest = {
        completeFunctionCalls = true,
      },
      inlayHints = {
        enumMemberValues = {
          enabled = true,
        },
        parameterNames = {
          enabled = 'all',
          suppressWhenArgumentMatchesName = true,
        },
        propertyDeclarationTypes = {
          enabled = true,
        },
        variableTypes = {
          enabled = true,
          suppressWhenTypeMatchesName = true,
        },
      },
    },
  },
}

M.opts = opts

return M
