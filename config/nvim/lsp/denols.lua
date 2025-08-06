return {
  root_dir = function (bufnr, on_dir)
    local type, dir = require('plugins.lsp.typescript_project_type').detect(bufnr)
    if type == 'deno' then
      on_dir(dir)
    end
  end,
  settings = {
    typescript = {
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
