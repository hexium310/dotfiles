local dein_dir = vim.fs.normalize('$XDG_CACHE_HOME/dein')
local dein_core = vim.fs.joinpath(dein_dir, 'repos/github.com/Shougo/dein.vim')

if vim.fn.isdirectory(dein_core) == 1 then
  vim.opt.runtimepath:prepend(dein_core)

  local dein = require('dein')

  vim.g['dein#isntall_github_api_token'] = vim.env.DEIN_GITHUB_TOKEN
  vim.env.HOOKS_DIR = vim.fs.joinpath(vim.fn.stdpath('config'), 'plugins/hooks')

  if dein.load_state(dein_dir) == 1 then
    dein.begin(dein_dir)

    vim.iter(vim.fs.find(function (name)
      return name:match('.*%.toml$')
    end, {
      path = vim.fs.normalize('$XDG_CONFIG_HOME/nvim/plugins'),
      limit = math.huge,
    })):each(function (file)
      dein.load_toml(file)
    end)

    if dein.check_install() then
      dein.install()
    end

    dein.end_()
    dein.save_state()
  end
end

vim.cmd.runtime({ 'userautoload/*.lua', bang = true })
