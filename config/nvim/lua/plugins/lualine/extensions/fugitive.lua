local onedark = require('onedark.colors')
local theme = require('lualine.themes.onedark')

local function git_branch()
  -- gets a branch in `Heads: <branch>` in the first line of the fugitive buffer
  return vim.api.nvim_buf_get_lines(0, 0, 1, false)[1]:sub(7)
end

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
        git_branch,
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
      git_branch,
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
