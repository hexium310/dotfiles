local lspconfig = require('lspconfig')

local utils = require('plugins/utils')
local lsp_utils = require('plugins/lsp/utils')
local diagnostic = require('plugins/lsp/diagnostic')
local default = require('plugins/lsp/servers/default')

local M = {}

---@param server string
---@param opts table|nil
local function setup_server(server, opts)
  lspconfig[server].setup(vim.tbl_deep_extend('force', default, {
    capabilities = require('cmp_nvim_lsp').default_capabilities(),
  }, opts or {}))
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
    local opts = {
      on_attach = function (client, bufnr)
        local namespace = vim.lsp.diagnostic.get_namespace(client.id)
        local goto_opts = {
          namespace = namespace,
          float = lsp_utils.float_opts,
        }
        local maps = {
          { 'n', ']a', function () vim.diagnostic.goto_next(goto_opts) end },
          { 'n', '[a', function () vim.diagnostic.goto_prev(goto_opts) end },
          { 'n', '<F8>', vim.lsp.buf.format({ async = true }) },
        }

        diagnostic.ignore_signs(namespace)
        utils.set_keymaps(maps, {
          buffer = bufnr,
          silent = true,
        })
        lsp_utils.set_document_formatting(client, true)
      end,
      settings = {
        format = {
          enable = true,
        },
      },
    }

    setup_server(server, opts)
  end,
  ---@param server string
  jsonls = function (server)
    local json_schemas = require('plugins/lsp/json_schemas')
    json_schemas.setup()

    local opts = {
      on_attach = function (client, bufnr)
        lsp_utils.set_document_formatting(client, false)
        default.on_attach(client, bufnr)
      end,
      settings = {
        json = {
          schemas = json_schemas.decode().schemas,
        },
      },
    }

    setup_server(server, opts)
  end,
  ---@param _ string
  rust_analyzer = function (_)
  end,
  ---@param server string
  lua_ls = function (server)
    require('neodev').setup({})

    local opts = {
      on_attach = function (client, bufnr)
        default.on_attach(client, bufnr)
      end,
      settings = {
        Lua = {
          hover = {
            previewFields = 100,
          },
          completion = {
            requireSeparator = '/',
          },
        },
      },
    }

    setup_server(server, opts)
  end,
  ---@param server string
  tailwindcss = function (server)
    local opts = {
      filetypes = {
        'html',
        'javascriptreact',
        'typescriptreact',
      },
    }

    setup_server(server, opts)
  end,
  ---@param server string
  tsserver = function (server)
    if not lspconfig.util.root_pattern('package.json')(vim.fn.getcwd()) then
      return
    end

    local opts = {
      on_attach = function (client, bufnr)
        lsp_utils.set_document_formatting(client, false)
        default.on_attach(client, bufnr)
      end,
    }

    setup_server(server, opts)
  end,
  vimls = function (server)
    local opts = {
      on_attach = function (client, bufnr)
        vim.keymap.del('n', 'K', { buffer = bufnr })
        default.on_attach(client,bufnr)
      end
    }

    setup_server(server, opts)
  end,
  yamlls = function (server)
    local opts = {
      settings = {
        yaml = {
          schemas = {
            kubernetes = {
              '/*manifests*/**/*.yaml',
              '/*manifests*/*.yaml',
            },
          }
        },
      },
    }

    setup_server(server, opts)
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
