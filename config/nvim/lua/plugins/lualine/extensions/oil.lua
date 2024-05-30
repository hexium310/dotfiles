local onedark = require('onedark.colors')
local theme = require('lualine.themes.onedark')

local oil = {
  sections = {
    lualine_a = {
      {
        'mode',
      },
    },
    lualine_b = {
      {
        'filename',
        symbols = {
          modified = ' +',
          readonly = '',
        },
        path = 1,
      }
    },
    lualine_y = { 'location' },
  },
  inactive_sections = {
    lualine_b = {
      {
        'filename',
        path = 1,
        symbols = {
          modified = ' +',
          readonly = '',
        },
        color = {
          fg = onedark.black.gui,
          bg = onedark.white.gui,
        },
      },
    },
    lualine_y = {
      {
        'location',
        color = {
          fg = theme.inactive.c.fg,
          bg = theme.inactive.c.bg,
        },
      },
    },
  },
  filetypes = { 'oil' },
}

return oil
