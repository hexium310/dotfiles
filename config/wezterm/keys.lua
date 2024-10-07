local wezterm = require('wezterm')

local M = {}

function M.apply(config)
  config.keys = {
    {
      key = 'k',
      mods = 'CTRL | SHIFT',
      action = wezterm.action.ShowDebugOverlay,
    },
    {
      key = '^',
      mods = 'CTRL',
      action = wezterm.action.DisableDefaultAssignment,
    },
  }
config.debug_key_events = true
end


return M
