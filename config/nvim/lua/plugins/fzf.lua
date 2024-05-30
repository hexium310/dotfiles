local fzf = require('fzf-lua')
local actions = require('fzf-lua.actions')

fzf.setup({
  'max-perf',
  winopts = {
    width = 0.90,
    preview = {
      vertical = 'up:45%',
      horizontal = 'right:45%',
      title = true,
    },
    on_create = function ()
      vim.opt_local.number = false
      vim.opt_local.relativenumber = false
    end,
  },
  actions = {
    files = vim.tbl_extend('force', fzf.config.defaults.actions.files, {
      ['ctrl-s'] = false,
      ['ctrl-x'] = actions.file_split,
    }),
    buffers = vim.tbl_extend('force', fzf.config.defaults.actions.buffers, {
      ['ctrl-s'] = false,
      ['ctrl-x'] = actions.buf_split,
    }),
  },
  fzf_opts = {
    ['--layout'] = 'default',
  },
  git = {
    files = {
      cmd = 'git ls-files -co --exclude-standard',
    },
  },
  grep = {
    winopts = {
      preview = {
        vertical = 'up:45%',
        layout = 'vertical',
      },
    },
  },
  oldfiles = {
    include_current_session = true,
  },
  lsp = {
    code_actions = {
      winopts = {
        preview = {
          vertical = 'up:70%',
          layout = 'vertical',
        },
      },
    },
  },
})
vim.env.DELTA_FEATURES = '+codeaction-preview'

local function show_fzf(callback)
  local disables = {
    'Trouble',
    'fugitive',
    'lazy',
    'toggleterm',
  }

  return function ()
    if vim.iter(disables):any(function (filetype) return vim.opt_local.filetype:get() == filetype end) then
      return
    end

    callback()
  end
end

local function fzf_dirs(opts)
  local default_otps = {
    prompt = 'Directories> ',
    actions = {
      ['default'] = function(selected)
        require('oil').open_float(selected[1])
      end,
    },
  }
  opts = vim.tbl_deep_extend('force', opts, default_otps)

  fzf.fzf_exec('fd --type d', opts)
end

vim.keymap.set('n', '<C-p>', show_fzf(fzf.git_files))
vim.keymap.set('n', '<Space><C-m>', show_fzf(fzf.oldfiles))
vim.keymap.set('n', '<Space>e', show_fzf(fzf.buffers))
vim.keymap.set('n', '<Space>r', show_fzf(fzf.grep_project))
vim.keymap.set('n', '<Space>f', show_fzf(function () fzf_dirs({}) end))

vim.api.nvim_create_user_command('Rg', function (t)
 fzf.grep_project({ search = t.args })
end, { nargs = '*' })
vim.api.nvim_create_user_command('Commits', fzf.git_commits, {})
vim.api.nvim_create_user_command('BCommits', fzf.git_bcommits, {})
