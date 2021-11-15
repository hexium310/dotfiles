local M = {}

local lsp_installer_servers = require('nvim-lsp-installer.servers')

function M.install(servers, force)
  local uninstalled_servers = vim.tbl_filter(function(server)
    return force or server and not server:is_installed()
  end, vim.tbl_map(function (s)
    local ok, server = lsp_installer_servers.get_server(s)
    return ok and server
  end, servers))

  for _, server in ipairs(uninstalled_servers) do
    server:install()
    print(server.name .. ' has been installed.')
  end
end

function M.update(force)
  local updates = require('plugins/lsp/update').check_update()

  M.install(vim.tbl_keys(updates), force or false)

  if vim.tbl_count(updates) > 0 then
    print(vim.inspect(updates))
  end
end

return M
