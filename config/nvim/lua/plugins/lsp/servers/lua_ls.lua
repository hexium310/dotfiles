local M = {}

local opts = {
  settings = {
    Lua = {
      hover = {
        previewFields = 100,
      },
    },
  },
}

M.opts = opts

M.setup = function ()
  require('neodev').setup({})
end

return M
