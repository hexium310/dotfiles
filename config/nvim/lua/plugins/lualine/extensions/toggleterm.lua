local theme = require('lualine.themes.onedark')

local function path()
  return vim.b.terminal_current_directory or ''
end

local toggleterm = {
  sections = {
    lualine_a = {
      path,
    },
    lualine_x = { 'location' },
  },
  inactive_sections = {
    lualine_a = {
      path,
    },
    lualine_x = {
      {
        'location',
        color = {
          fg = theme.inactive.c.fg,
          bg = theme.inactive.c.bg,
        },
      },
    },
  },
  filetypes = { 'toggleterm' },
}

return toggleterm
