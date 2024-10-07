local wezterm = require('wezterm')
local appearance = require('appearance')
local keys = require('keys')

local config = wezterm.config_builder()

config.automatically_reload_config = true

config.font = wezterm.font('HackGen Console NF')
config.font_size = 11
config.check_for_updates = true

config.default_prog = {
  'C:/Windows/system32/wsl.exe',
  '--cd',
  '~',
  '--distribution',
  'arch',
  '--exec',
  '/bin/zsh',
  '-c',
  'tmux new -A && exec zsh -i',
}

appearance.apply(config)
keys.apply(config)

return config
