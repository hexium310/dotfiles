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
  on_attach = function (client, bufnr)
    local goto_opts = {
      float = lsp_utils.float_opts,
    }
    local maps = {
      { { 'n', 'i' }, '<F2>', vim.lsp.buf.rename },
      { 'n', '<F3>', vim.lsp.buf.code_action },
      { 'n', 'K', require('plugins/lsp/utils').hover },
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

    if client.server_capabilities.inlayHintProvider then
      vim.lsp.inlay_hint.enable(0, true)
    end

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
  end,
}

---@param server string
---@param opts table|nil
local function setup_server(server, opts)
  lspconfig[server].setup(vim.tbl_deep_extend('force', general, {
    capabilities = require('cmp_nvim_lsp').default_capabilities(),
  }, opts or {}))
end

local servers = {
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
  ---@param _ string
  rust_analyzer = function (_)
    local opts = {
      tools = {
        inlay_hints = {
          auto = false,
          show_parameter_hints = false,
          other_hints_prefix = '-> ',
        },
      },
      server = vim.tbl_deep_extend('force', general, {
        standalone = true,
        capabilities = require('cmp_nvim_lsp').default_capabilities(),
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
  ---@param server string
  lua_ls = function (server)
    require('neodev').setup({})

    local opts = {
      on_attach = function (client, bufnr)
        general.on_attach(client, bufnr)
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
    local opts = {
      on_attach = function (client, bufnr)
        lsp_utils.set_document_formatting(client, false)
        general.on_attach(client, bufnr)
      end,
    }

    setup_server(server, opts)
  end,
  vimls = function (server)
    local opts = {
      on_attach = function (client, bufnr)
        vim.keymap.del('n', 'K', { buffer = bufnr })
        general.on_attach(client,bufnr)
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

M.general = general

return M
