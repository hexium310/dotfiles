local M = {}

local lsp_installer_servers = require('nvim-lsp-installer.servers')

function M.install(servers, force)
  for _, s in ipairs(servers) do
    local ok, server = lsp_installer_servers.get_server(s)
    if not ok or (not force and server:is_installed()) then
      return
    end

    server:install()
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
