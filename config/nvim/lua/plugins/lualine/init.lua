local onedark = require('onedark/colors')
local theme = require('lualine/themes/onedark')

local toggleterm = require('plugins/lualine/toggleterm')
local fugitive = require('plugins/lualine/fugitive')

theme.normal.a.gui = nil
theme.insert.a.gui = nil
theme.visual.a.gui = nil
theme.replace.a.gui = nil
theme.command.a.gui = nil
theme.inactive.a.gui = nil

require('lualine').setup({
  options = {
    icons_enabled = false,
    theme = theme,
    component_separators = {
      left = '|',
      right = '|',
    },
    section_separators = {
      left = '',
      right = '',
    },
  },
  sections = {
    lualine_a = { 'mode' },
    lualine_b = {
      {
        -- readonly
        function ()
          return vim.api.nvim_get_option('readonly') and 'RO' or ''
        end,
        color = {
          fg = onedark.black.gui,
          bg = onedark.red.gui,
        },
      },
      {
        'filename',
        symbols = {
          modified = ' +',
          readonly = '',
        },
        color = function ()
          if vim.fn.expand('%'):find('^fugitive:') == 1 then
            return {
              fg = onedark.black.gui,
              bg = onedark.dark_yellow.gui,
            }
          else
            return {}
          end
        end,
      },
      {
        -- filepath
        function ()
          return ('%.35s'):format(vim.fn.expand('%:h:s')):gsub('$', '/')
        end,
      },
    },
    lualine_c = {
      {
        'diagnostics',
        diagnostics_color = {
          error = 'StatusLineDiagnosticError',
          warn  = 'StatusLineDiagnosticWarn',  -- Changes diagnostics' warn color.
          info  = 'lualine_c_normal',  -- Changes diagnostics' info color.
          hint  = 'lualine_c_normal',
        },
        fmt = function (str)
          return str:gsub(':', ': ')
        end,
      },
      {
        -- search count
        function ()
          local count = vim.fn.searchcount({ recompute = false })
          return vim.v.hlsearch ~= 0 and ('%s(%s/%s)'):format(vim.fn.getreg('/'), count.current, count.total) or ''
        end
      },
    },
    lualine_x = {},
    lualine_y = {
      {
        -- fileencoding
        function ()
          local encoding = vim.api.nvim_get_option('fileencoding')
          return encoding == 'utf-8' and '' or encoding
        end,
      },
      'filetype',
      'location',
    },
    lualine_z = {},
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {
      {
        'filename',
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
    lualine_c = {},
    lualine_x = { 'location' },
    lualine_y = {},
    lualine_z = {},
  },
  tabline = {
    lualine_a = {
      {
        'tabs',
        max_length = vim.o.columns * 4 / 5,
        mode = 2,
        tabs_color = {
          active = {
            fg = onedark.black.gui,
            bg = onedark.white.gui,
          },
          inactive ={
            fg = onedark.white.gui,
            bg = onedark.black.gui,
          },
        },
      },
    },
    lualine_b = {
      {
        -- git diff
        function ()
          return vim.b.gitsigns_status or ''
        end,
      },
    },
    lualine_c = {},
    lualine_x = {},
    lualine_y = {},
    lualine_z = {
      {
        'branch',
        color = {
          fg = onedark.black.gui,
          bg = onedark.white.gui,
        },
      },
    },
  },
  extensions = {
    fugitive,
    toggleterm,
    'quickfix',
  },
})
