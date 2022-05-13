local lspconfig = require('lspconfig')

local utils = require('plugins/utils')
local lsp_utils = require('plugins/lsp/utils')
local diagnostic = require('plugins/lsp/diagnostic')

local M = {}

local general = {
  commands = {
    RenameFile = {
      function ()
        require('plugins/lsp/utils').rename_file()
      end,
    },
  },
  handlers = {
    ['textDocument/hover'] = vim.lsp.with(vim.lsp.handlers.hover, {
      border = 'rounded',
      focusable = false,
    }),
    ['textDocument/signatureHelp'] = vim.lsp.with(vim.lsp.handlers.signature_help, {
      border = 'rounded',
      silent = true,
      focusable = false,
    }),
  },
  on_attach = function (_, bufnr)
    local goto_opts = {
      float = lsp_utils.float_opts,
    }
    local maps = {
      { { 'n', 'i' }, '<F2>', vim.lsp.buf.rename },
      { 'n', 'K', require('plugins/lsp/utils').hover_or_open_vim_help },
      { 'n', 'gf', vim.lsp.buf.definition },
      { 'n', ']c', function () vim.diagnostic.goto_next(goto_opts) end },
      { 'n', '[c', function () vim.diagnostic.goto_prev(goto_opts) end },
      { 'n', '<C-d>', function () require('plugins/lsp/utils').send_key('<C-d>', bufnr) end },
      { 'n', '<C-u>', function () require('plugins/lsp/utils').send_key('<C-u>', bufnr) end },
      { 'n', '<C-f>', function () require('plugins/lsp/utils').send_key('<C-f>', bufnr) end },
      { 'n', '<C-b>', function () require('plugins/lsp/utils').send_key('<C-b>', bufnr) end },
    }

    utils.set_keymaps(maps, {
      buffer = bufnr,
      silent = true,
    })

    vim.api.nvim_create_augroup('LspConfig', { clear = false })

    utils.create_unique_autocmd({ 'CursorHold' }, {
      group = 'LspConfig',
      buffer = bufnr,
      desc = 'Open diagnostic float',
      callback = function ()
        vim.diagnostic.open_float(vim.tbl_extend('error', {
          scope = 'cursor',
        }, lsp_utils.float_opts))
      end,
    })

    utils.create_unique_autocmd({ 'CursorHoldI' }, {
      group = 'LspConfig',
      buffer = bufnr,
      desc = 'Open signature help',
      callback = function ()
        if not require('cmp').visible() then
          require('plugins/lsp/utils').signature_help()
        end
      end,
    })
  end,
}

---@param server Server
---@param opts table|nil
local function setup_server(server, opts)
  lspconfig[server.name].setup(vim.tbl_deep_extend('force', general, {
    capabilities = lsp_utils.get_cmp_nvim_lsp_capabilities(),
  }, opts or {}))
end

local servers = {
  ---@param server Server
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
          { 'n', '<F8>', vim.lsp.buf.formatting },
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
  ---@param server Server
  jsonls = function (server)
    local json_schemas = require('plugins/lsp/json_schemas')
    json_schemas.setup()

    local opts = {
      on_attach = function (client, bufnr)
        lsp_utils.set_document_formatting(client, false)
        general.on_attach(client, bufnr)
      end,
      settings = {
        json = {
          schemas = json_schemas.decode().schemas,
        },
      },
    }

    setup_server(server, opts)
  end,
  ---@param _ Server
  rust_analyzer = function (_)
    local opts = {
      tools = {
        autoSetHints = true,
        hover_with_actions = false,
        inlay_hints = {
          show_parameter_hints = false,
          show_variable_name = true,
          other_hints_prefix = '-> ',
        },
      },
      server = vim.tbl_deep_extend('force', general, {
        standalone = true,
        capabilities = lsp_utils.get_cmp_nvim_lsp_capabilities(),
        settings = {
          ['rust-analyzer'] = {
            checkOnSave = {
              command = 'clippy',
            },
          },
        },
      }),
    }

    require('rust-tools').setup(opts)
  end,
  ---@param server Server
  sumneko_lua = function (server)
    local opts = require('lua-dev').setup({
      runtime_path = true,
      lspconfig = vim.tbl_deep_extend('force', general, {
        capabilities = lsp_utils.get_cmp_nvim_lsp_capabilities(),
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
      })
    })

    vim.list_extend(opts.settings.Lua.workspace.library, vim.api.nvim_get_runtime_file('lua/', true))

    setup_server(server, opts)
  end,
  ---@param server Server
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
  ---@param server Server
  tsserver = function (server)
    local opts = {
      on_attach = function (client, bufnr)
        lsp_utils.set_document_formatting(client, false)
        general.on_attach(client, bufnr)
      end,
    }

    setup_server(server, opts)
  end,
  ---@param server Server
  ['null-ls'] = function (server)
    local opts = {
      on_attach = function (_, bufnr)
        local namespaces = vim.tbl_map(function (source)
          return require('null-ls/diagnostics').get_namespace(source.id)
        end, require('null-ls').get_sources())

        for _, namespace in ipairs(namespaces) do
          local goto_opts = {
            namespace = namespace,
            float = lsp_utils.float_opts,
          }
          local maps = {
            { 'n', ']a', function () vim.diagnostic.goto_next(goto_opts) end },
            { 'n', '[a', function () vim.diagnostic.goto_prev(goto_opts) end },
          }

          diagnostic.ignore_signs(namespace)
          utils.set_keymaps(maps, {
            buffer = bufnr,
            silent = true,
          })
        end
      end,
    }

    setup_server(server, opts)
  end,
}

setmetatable(servers, {
  __index = function (_, _)
    ---@param server Server
    return function (server)
      setup_server(server)
    end
  end,
})

function M.setup()
  require('nvim-lsp-installer').setup()

  for _, server in ipairs(require('nvim-lsp-installer').get_installed_servers()) do
    servers[server.name](server)
  end
end

M.general = general

return M
