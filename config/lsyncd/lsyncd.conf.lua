local function uname()
  local handle = io.popen('uname -r')

  if handle == nil then
    return ''
  end

  local result = handle:read('*a')
  handle:close()

  return result
end

local is_wsl = uname():find('.*%-microsoft%-.*') ~= nil

if is_wsl then
  local current_file = debug.getinfo(1, 'S').source:match('^@?(.*[%/])[^%/]-$')

  dofile(('%s/wsl.lua'):format(current_file))
end

settings({
  insist = true,
})
