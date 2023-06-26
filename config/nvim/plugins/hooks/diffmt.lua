-- lua_add {{{
vim.api.nvim_create_user_command('Diffmt', function() require('diffmt').diff() end, {})
-- }}}
