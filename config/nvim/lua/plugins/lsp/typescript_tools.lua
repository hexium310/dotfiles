require('typescript-tools').setup({
  single_file_support = false,
  root_dir = function (bufnr, on_dir)
    local type, dir = require('plugins.lsp.typescript_project_type').detect(bufnr)
    if type == 'node' then
      on_dir(dir)
    end
  end,
  settings = {
    complete_function_calls = true,
    tsserver_file_preferences = {
      importModuleSpecifierPreference = 'non-relative',
      preferTypeOnlyAutoImports = true,
    },
  },
})
