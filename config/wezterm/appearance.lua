local wezterm = require('wezterm')

local M = {}

function M.apply(config)
  config.initial_rows = 46
  config.initial_cols = 160

  config.color_scheme = 'Tomorrow Night Eighties'

  config.font = wezterm.font('HackGen Console NF')
  config.font_size = 11

  config.enable_tab_bar = false

  config.animation_fps = 1
  config.cursor_blink_ease_in = 'Constant'
  config.cursor_blink_ease_out = 'Constant'

  config.ui_key_cap_rendering = 'WindowsSymbols'

  config.window_decorations = 'RESIZE'
  config.window_padding = {
    left = 0,
    right = 0,
    top = 0,
    bottom = 0,
  }

  wezterm.on('gui-startup', function (cmd)
    local _, _, window = wezterm.mux.spawn_window(cmd or {})

    local gui_window = window:gui_window()
    gui_window:set_position(0, 0)
  end)
end

return M
