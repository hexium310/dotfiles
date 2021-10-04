local lspinstall = require('lspinstall')

local function _install(servers)
  for _, v in ipairs(servers) do
    lspinstall.install_server(v)
  end
end

local M = {
  install = function (self)
    lspinstall.post_install_hook = function ()
      vim.cmd([[startinsert]])
      vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes('<Cr>', true, false, true), 'n', true)
    end

    _install(self:not_installed_servers())

    lspinstall.post_uninstall_hook = function() end
  end,
  update = function (self, all)
    lspinstall.post_install_hook = function ()
      vim.cmd([[startinsert]])
      vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes('<Cr>', true, false, true), 'n', true)
    end

    if all then
      _install(self.servers)
    else
      local servers = require('plugins/lsp/update').check_update()

      _install(vim.tbl_keys(servers))
      print(vim.inspect(servers))
    end

    lspinstall.post_uninstall_hook = function() end
  end,
  installed_servers = function (self)
    return vim.tbl_filter(function (key)
      return vim.tbl_contains(self.servers, key)
    end, lspinstall.installed_servers())
  end,
  not_installed_servers = function (self)
    return vim.tbl_filter(function (key)
      return vim.tbl_contains(self.servers, key)
    end, lspinstall.not_installed_servers())
  end,
}

return M
