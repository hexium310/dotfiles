local M = {}

local dir = vim.fn.stdpath('data') .. '/schemastore'
local file = dir .. '/catalog.json'

function M.download()
  vim.fn.mkdir(dir, 'p')
  vim.fn.jobstart({
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
  return vim.fn.json_decode(vim.fn.readfile(file))
end

function M.setup()
  if vim.fn.findfile(file) == '' then
    M.download()
  end
end

return M
