local xdg_config_home = os.getenv('XDG_CONFIG_HOME') or '/home/hexin/.config'
local appdata = os.getenv('APPDATA') or '/mnt/c/Users/Hexin/AppData/Roaming'

local transitions = {
  {
    source = ('%s/alacritty/'):format(xdg_config_home),
    target = ('%s/alacritty/'):format(appdata),
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
