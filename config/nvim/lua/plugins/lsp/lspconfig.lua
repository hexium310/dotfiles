local lspconfig = require('lspconfig')

local default = require('plugins.lsp.servers.default')

local M = {}

---@param server string
---@param opts table|nil
local function setup_server(server, opts)
  lspconfig[server].setup(vim.tbl_deep_extend('force', default, opts or {}))
end

local servers = {
  ---@param server any
  denols = function (server)
    if lspconfig.util.root_pattern('package.json')(vim.fn.getcwd()) then
      return
    end

    setup_server(server, {})
  end,
  ---@param server string
  eslint = function (server)
    local config = require('plugins.lsp.servers.eslint')

    setup_server(server, config.opts)
  end,
  ---@param server string
  jsonls = function (server)
    local config = require('plugins.lsp.servers.jsonls')

    config.setup()
    setup_server(server, config.opts)
  end,
  ---@param _ string
  rust_analyzer = function (_)
  end,
  ---@param server string
  lua_ls = function (server)
    local config = require('plugins.lsp.servers.lua_ls')

    config.setup()
    setup_server(server, config.opts)
  end,
  ---@param server string
  tailwindcss = function (server)
    local config = require('plugins.lsp.servers.tailwindcss')

    setup_server(server, config.opts)
  end,
  ---@param server string
  tsserver = function (server)
    if not lspconfig.util.root_pattern('package.json')(vim.fn.getcwd()) then
      return
    end

    local config = require('plugins.lsp.servers.tsserver')

    setup_server(server, config.opts)
  end,
  vimls = function (server)
    local config = require('plugins.lsp.servers.vimls')

    setup_server(server, config.opts)
  end,
  yamlls = function (server)
    local config = require('plugins.lsp.servers.yamlls')

    setup_server(server, config.opts)
  end,
}

function M.setup()
  require('mason-lspconfig').setup({})
  require('mason-lspconfig').setup_handlers(vim.tbl_deep_extend('force', {
    setup_server,
  }, servers))
end

M.general = default

return M
