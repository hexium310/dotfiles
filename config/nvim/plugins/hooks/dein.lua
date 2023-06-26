-- lua_add {{{
local dein = require('dein')

vim.api.nvim_create_user_command('DeinUpdate', function () dein.update() end, { nargs = 0 })
vim.api.nvim_create_user_command('DeinRecache', function () dein.recache_runtimepath() end, { nargs = 0 })
vim.api.nvim_create_autocmd('VimEnter', {
  callback = function ()
    vim.schedule(function ()
      dein.call_hook('post_source')
    end)
  end,
})
-- }}}
