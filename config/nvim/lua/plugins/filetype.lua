local function init()
  require('filetype').setup({
    overrides = {
      complex = {
        ['queries/.+/.+%.scm'] = 'query'
      }
    }
  })
end

return init
