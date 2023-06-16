local M = {}

local dir = vim.fs.joinpath(vim.fn.stdpath('data'), 'schemastore')
local file = vim.fs.joinpath(dir, 'catalog.json')

function M.download()
  vim.fn.mkdir(dir, 'p')
  vim.system({
    'curl',
    '-sL',
    '-o',
    'catalog.json',
    'https://www.schemastore.org/api/json/catalog.json',
  }, {
    cwd = dir,
  })
end

function M.decode()
  local file_handle = assert(io.open(file))
  local json = vim.json.decode(file_handle:read("*a"))
  file_handle:close()

  return json
end

function M.get_catalog_path()
  return file
end

function M.setup()
  if vim.fn.findfile(file) == '' then
    M.download()
  end
end

return M
