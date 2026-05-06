---@type vim.lsp.Config
return {
  root_dir = function (bufnr, on_dir)
    local type, dir = require('plugins.lsp.typescript_project_type').detect(bufnr)
    if type == 'node.tsgo' then
      on_dir(dir)
    end
  end,
}
