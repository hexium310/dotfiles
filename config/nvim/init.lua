local dein_dir = vim.fs.joinpath(vim.fn.stdpath('data'), 'dein')
local dein_core = vim.fs.joinpath(dein_dir, 'repos/github.com/Shougo/dein.vim')

if vim.fn.isdirectory(dein_core) ~= 1 then
  local result = vim.system({
    'git',
    'clone',
    '--depth=1',
    'https://github.com/Shougo/dein.vim',
    dein_core,
  }):wait()

  if result.code ~= 0 then
    vim.notify_once('Cloning dein.vim failed: ' .. result.stderr, vim.log.levels.ERROR)
  end
end

if vim.fn.isdirectory(dein_core) == 1 then
  vim.opt.runtimepath:prepend(dein_core)

  local dein = require('dein')

  vim.g['dein#isntall_github_api_token'] = vim.env.DEIN_GITHUB_TOKEN

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
