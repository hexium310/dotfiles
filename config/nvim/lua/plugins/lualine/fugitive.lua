local onedark = require('onedark/colors')
local theme = require('lualine/themes/onedark')

local function git_root()
  return vim.fn.fnamemodify(vim.fn.FugitiveGitDir(), ':~:h')
end

local fugitive = {
  sections = {
    lualine_a = {
      {
        'mode',
      },
    },
    lualine_b = {
      {
        'FugitiveHead',
        color = function ()
          return {
            fg = onedark.black.gui,
            bg = onedark.white.gui,
            gui = 'bold',
          }
        end,
      },
      git_root,
    },
    lualine_y = { 'location' },
  },
  inactive_sections = {
    lualine_b = {
      'FugitiveHead',
      git_root,
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
  filetypes = { 'fugitive' },
}

return fugitive
