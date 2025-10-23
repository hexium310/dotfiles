---@type vim.lsp.Config
return {
  settings = {
    gopls = {
      semanticTokens = true,
      hints = {
        assignVariableTypes = true,
      },
    },
  },
}
