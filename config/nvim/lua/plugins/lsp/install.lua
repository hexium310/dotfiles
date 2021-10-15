local M = {}

local lsp_installer_servers = require('nvim-lsp-installer.servers')

function M.install(servers)
  for _, s in ipairs(servers) do
    local ok, server = lsp_installer_servers.get_server(s)
    if not ok or server:is_installed() then
      return
    end

    server:install()
  end
end

return M
