local xdg_config_home = os.getenv('XDG_CONFIG_HOME') or '/home/hexin/.config'
local userprofile = os.getenv('USERPROFILE') or '/mnt/c/Users/Hexin'
local appdata = os.getenv('APPDATA') or '/mnt/c/Users/Hexin/AppData/Roaming'
local localappdata = os.getenv('LOCALAPPDATA') or '/mnt/c/Users/Hexin/AppData/Local'

local transfers = {
  {
    source = ('%s/alacritty/'):format(xdg_config_home),
    target = ('%s/alacritty/'):format(appdata),
  },
  {
    source = ('%s/autohotkey/'):format(xdg_config_home),
    target = ('%s/Documents/AutoHotkey/'):format(userprofile),
  },
  {
    source = ('%s/srcurl/'):format(xdg_config_home),
    target = ('%s/srcurl/'):format(localappdata),
  },
}

for _, transfer in ipairs(transfers) do
  ---@diagnostic disable-next-line: undefined-global
  sync({
    ---@diagnostic disable-next-line: undefined-global
    default.rsync,
    delay = 0,
    transfer,
  })
end
