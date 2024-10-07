local xdg_config_home = os.getenv('XDG_CONFIG_HOME') or '/home/hexin/.config'
local appdata = os.getenv('APPDATA') or '/mnt/c/Users/Hexin/AppData/Roaming'

local transfers = {
  {
    source = ('%s/alacritty/'):format(xdg_config_home),
    target = ('%s/alacritty/'):format(appdata),
  },
}

for _, transfer in ipairs(transfers) do
  sync({
    default.rsync,
    delay = 0,
    source = transfer.source,
    target = transfer.target,
  })
end
