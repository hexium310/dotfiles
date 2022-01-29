local utils = require('plugins/utils')
local lsp_utils = require('plugins/lsp/utils')

local M = {}

local namespaces_without_signs = {}

local function ignore_signs(namespace)
  if not vim.tbl_contains(namespaces_without_signs, namespace) then
    table.insert(namespaces_without_signs, namespace)
  end
end

local function set_document_formatting(client, bool)
  client.resolved_capabilities.document_formatting = bool
  client.resolved_capabilities.document_range_formatting = bool
end

local function format_on_save()
  vim.cmd([[autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_sync(nil, 1000)]])
end

local function get_cmp_nvim_lsp_capabilities()
  local capabilities = vim.lsp.protocol.make_client_capabilities()
  return require('cmp_nvim_lsp').update_capabilities(capabilities)
end

local function reset_diagnostic()
  vim.diagnostic.reset(nil, 0)
  package.loaded['vim.diagnostic'] = nil
  vim.diagnostic = require('vim.diagnostic')
end

local function separate_and_sort(diagnostics)
  local severity = vim.diagnostic.severity
  local linter = {
    [severity.ERROR] = {},
    [severity.WARN] = {},
    [severity.INFO] = {},
    [severity.HINT] = {},
  }
  local lsp = {
    [severity.ERROR] = {},
    [severity.WARN] = {},
    [severity.INFO] = {},
    [severity.HINT] = {},
  }

  for _, diagnostic in ipairs(diagnostics) do
    local list = vim.tbl_contains(namespaces_without_signs, diagnostic.namespace) and linter or lsp
    table.insert(list[diagnostic.severity], diagnostic)
  end

  return linter, lsp
end

local general = {
  commands = {
    RenameFile = {
      function ()
        require('plugins/lsp/utils').rename_file()
        vim.fn['lightline#update']()
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
  end
}

local languages = {
  eslint = function ()
    return {
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

        ignore_signs(namespace)
        utils.set_keymaps(maps, {
          buffer = bufnr,
          silent = true,
        })
        set_document_formatting(client, true)
      end,
      settings = {
        format = {
          enable = true,
        },
      },
    }
  end,
  jsonls = function ()
    local json_schemas = require('plugins/lsp/json_schemas')
    json_schemas.setup()

    return {
      on_attach = function (client, bufnr)
        set_document_formatting(client, false)
        general.on_attach(client, bufnr)
      end,
      settings = {
        json = {
          schemas = json_schemas.decode().schemas,
        },
      },
    }
  end,
  sumneko_lua = function ()
    local runtime_path = vim.split(package.path, ';')
    table.insert(runtime_path, '?.lua')
    table.insert(runtime_path, '?/init.lua')

    return {
      settings = {
        Lua = {
          hover = {
            previewFields = 100,
          },
          completion = {
            requireSeparator = '/',
          },
          runtime = {
            version = 'LuaJIT',
            path = runtime_path,
          },
          diagnostics = {
            globals = { 'vim' },
          },
          workspace = {
            library = vim.api.nvim_get_runtime_file('lua/', true),
          },
        },
      },
    }
  end,
  tailwindcss = function ()
    return {
      filetypes = {
        'html',
        'javascriptreact',
        'typescriptreact',
      },
    }
  end,
  tsserver = function ()
    return {
      on_attach = function (client, bufnr)
        set_document_formatting(client, false)
        general.on_attach(client, bufnr)
      end,
    }
  end,
  ['null-ls'] = function ()
    return {
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

          ignore_signs(namespace)
          utils.set_keymaps(maps, {
            buffer = bufnr,
            silent = true,
          })
        end
      end,
    }
  end,
}

function M.lspconfig()
  local capabilities = get_cmp_nvim_lsp_capabilities()

  require('nvim-lsp-installer').on_server_ready(function (server)
    local lsp_config = vim.F.npcall(languages[server.name]) or {}

    server:setup(vim.tbl_deep_extend('force', {
      on_attach = general.on_attach,
      handlers = general.handlers,
      commands = general.commands,
      capabilities = capabilities,
    }, lsp_config))
  end)
end

function M.null_ls()
  local null_ls = require('null-ls')

  local capabilities = get_cmp_nvim_lsp_capabilities()
  local lsp_setting = vim.tbl_deep_extend('force', {
    on_attach = general.on_attach,
    handlers = general.handlers,
    commands = general.commands,
    capabilities = capabilities,
  }, vim.F.npcall(languages['null-ls']) or {})

  null_ls.setup(vim.tbl_deep_extend('force', {
    diagnostics_format = '(#{c}) #{m}',
    sources = {
      null_ls.builtins.diagnostics.luacheck,
    },
  }, lsp_setting))
end

function M.diagnostic()
  reset_diagnostic()

  vim.diagnostic.config({
    virtual_text = false,
    signs = true,
  })

  local orig_signs_handler = vim.diagnostic.handlers.signs
  local signs_namespace = vim.api.nvim_create_namespace('highest_severity_diagnostic_signs')
  vim.diagnostic.handlers.signs = {
    show = function (_, bufnr, _, opts)
      local diagnostics = vim.diagnostic.get(bufnr)
      diagnostics = vim.tbl_filter(function (diagnostic)
        return not vim.tbl_contains(namespaces_without_signs, diagnostic.namespace)
      end, diagnostics)

      local max_severity_per_line = {}
      for _, diagnostic in pairs(diagnostics) do
        local max = max_severity_per_line[diagnostic.lnum]
        if not max or diagnostic.severity < max.severity then
          max_severity_per_line[diagnostic.lnum] = diagnostic
        end
      end

      local filtered_diagnostics = vim.tbl_values(max_severity_per_line)
      orig_signs_handler.show(signs_namespace, bufnr, filtered_diagnostics, opts)
    end,
    hide = function (_, bufnr)
      orig_signs_handler.hide(signs_namespace, bufnr)
    end,
  }

  local orig_underline_handler = vim.diagnostic.handlers.underline
  local underline_namespace = vim.api.nvim_create_namespace('highest_severity_diagnostic_underline')
  vim.diagnostic.handlers.underline = {
    show = function (_, bufnr, _, opts)
      local diagnostics = vim.diagnostic.get(bufnr)
      local linter, lsp = separate_and_sort(diagnostics)
      diagnostics = vim.fn.flatten({ vim.tbl_values(linter), vim.tbl_values(lsp) })

      orig_underline_handler.show(underline_namespace, bufnr, diagnostics, opts)
    end,
    hide = function (_, bufnr)
      orig_underline_handler.hide(underline_namespace, bufnr)
    end,
  }

  vim.cmd([[
    sign define DiagnosticSignError text=E texthl=DiagnosticSignError linehl= numhl=
    sign define DiagnosticSignWarn text=W texthl=DiagnosticSignWarn linehl= numhl=
    sign define DiagnosticSignInfo text=I texthl=DiagnosticSignInfo linehl= numhl=
    sign define DiagnosticSignHint text=H texthl=DiagnosticSignHint linehl= numhl=
  ]])
end

return M
