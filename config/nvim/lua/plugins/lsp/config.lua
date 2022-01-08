local utils = require('plugins/lsp/utils')

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

local function set_keymap(bufnr, mappings)
  for _, v in ipairs(mappings) do
    local modes = v[1]
    local lhs = v[2]
    local rhs = v[3]
    local opts = {
      buffer = bufnr,
      silent = true,
    }

    vim.keymap.set(modes, lhs, rhs, opts)
  end
end

local function get_cmp_nvim_lsp_capabilities()
  local capabilities = vim.lsp.protocol.make_client_capabilities()
  return require('cmp_nvim_lsp').update_capabilities(capabilities)
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
      float = utils.float_opts,
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

    set_keymap(bufnr, maps)
  end
}

local languages = {
  eslint = function ()
    return {
      on_attach = function (client, bufnr)
        local namespace = vim.lsp.diagnostic.get_namespace(client.id)
        local goto_opts = {
          namespace = namespace,
          float = utils.float_opts,
        }
        local maps = {
          { 'n', ']a', function () vim.diagnostic.goto_next(goto_opts) end },
          { 'n', '[a', function () vim.diagnostic.goto_prev(goto_opts) end },
          { 'n', '<F8>', vim.lsp.buf.formatting() },
        }

        ignore_signs(namespace)
        set_keymap(bufnr, maps)
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
            float = utils.float_opts,
          }
          local maps = {
            { 'n', ']a', function () vim.diagnostic.goto_next(goto_opts) end },
            { 'n', '[a', function () vim.diagnostic.goto_prev(goto_opts) end },
          }

          ignore_signs(namespace)
          set_keymap(bufnr, maps)
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

function M.completion()
  local cmp = require('cmp')

  vim.o.completeopt = 'menuone,noselect'

  cmp.setup({
    sources = cmp.config.sources({
      {
        name = 'nvim_lsp',
      },
      {
        name = 'buffer',
      },
      {
        name = 'path',
      },
    }),
    snippet = {
      expand = function(args)
        vim.fn['vsnip#anonymous'](args.body)
      end,
    },
    mapping = {
      ['<C-b>'] = cmp.mapping(cmp.mapping.scroll_docs(-4), { 'i', 'c' }),
      ['<C-f>'] = cmp.mapping(cmp.mapping.scroll_docs(4), { 'i', 'c' }),
      ['<C-x><C-n>'] = cmp.mapping.complete(),
      ['<C-y>'] = cmp.mapping.confirm({
        select = true,
      }),
    },
    formatting = {
      format = function (entry, vim_item)
        vim_item.menu = ({
          nvim_lsp = '[LSP]',
          buffer = '[Buffer]',
          path = '[Path]',
        })[entry.source.name]

        return vim_item
      end,
    },
    documentation = {
      border = 'single',
    },
    preselect = cmp.PreselectMode.None,
  })

  cmp.event:on('confirm_done', require('nvim-autopairs/completion/cmp').on_confirm_done())
end

function M.diagnostic()
  vim.diagnostic.config({
    virtual_text = false,
    signs = true,
  })

  local orig_signs_handler = vim.diagnostic.handlers.signs
  local namespace = vim.api.nvim_create_namespace('highest_severity_diagnostic_signs')
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
      orig_signs_handler.show(namespace, bufnr, filtered_diagnostics, opts)
    end,
    hide = function(_, bufnr)
      orig_signs_handler.hide(namespace, bufnr)
    end,
  }
end

return M
