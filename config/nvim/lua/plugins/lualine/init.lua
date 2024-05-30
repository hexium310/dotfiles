local onedark = require('onedark.colors')
local theme = require('lualine.themes.onedark')

local toggleterm = require('plugins.lualine.extensions.toggleterm')
local fugitive = require('plugins.lualine.extensions.fugitive')
local oil = require('plugins.lualine.extensions.oil')

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
          return vim.api.nvim_get_option_value('readonly', {}) and 'RO' or ''
        end,
        color = {
          fg = onedark.black.gui,
          bg = onedark.red.gui,
        },
      },
      {
        'filename',
        newfile_status = true,
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
    lualine_x = {
      {
        -- recording
        function ()
          local recording = vim.fn.reg_recording()
          return recording ~= '' and ('● REC [%s]'):format(recording) or ''
        end,
        color = {
          fg = onedark.red.gui,
        },
      },
    },
    lualine_y = {
      {
        -- fileencoding
        function ()
          local encoding = vim.api.nvim_get_option_value('fileencoding', {})
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
        fmt = function (str)
          local bufnr = vim.fn.bufnr(str)

          if bufnr <= 0 then
            return str
          end

          local modified = vim.api.nvim_get_option_value('modified', { buf = bufnr }) and ' +' or ' '

          return str .. modified
        end,
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
    oil,
    'quickfix',
  },
})
