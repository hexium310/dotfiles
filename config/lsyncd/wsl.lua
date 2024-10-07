local xdg_config_home = os.getenv('XDG_CONFIG_HOME') or '/home/hexin/.config'
local user_profile = os.getenv('USERPROFILE') or '/mnt/c/Users/Hexin'
local appdata = os.getenv('APPDATA') or '/mnt/c/Users/Hexin/AppData/Roaming'

local transitions = {
  {
    source = ('%s/alacritty/'):format(xdg_config_home),
    target = ('%s/alacritty/'):format(appdata),
  },
  {
    source = ('%s/wezterm/'):format(xdg_config_home),
    target = ('%s/.config/wezterm/'):format(user_profile),
  },
}

for _, transition in ipairs(transitions) do
  sync({
    default.rsync,
    delay = 0,
    source = transition.source,
    target = transition.target,
  })
end
