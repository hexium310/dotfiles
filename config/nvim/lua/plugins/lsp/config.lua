local utils = require('plugins/lsp/utils')

local M = {}

local function set_document_formatting(client, bool)
  client.resolved_capabilities.document_formatting = bool
  client.resolved_capabilities.document_range_formatting = bool
end

local function format_on_save()
  vim.cmd([[autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_sync(nil, 1000)]])
end

local function set_keymap(bufnr, mappings)
  for _, v in ipairs(mappings) do
    local mode = v[1]
    local lhs = v[2]
    local rhs = v[3]

    vim.api.nvim_buf_set_keymap(bufnr, mode, lhs, rhs, { noremap = true, silent = true })
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
      { 'n', '<F2>', [[<Cmd>lua vim.lsp.buf.rename()<CR>]] },
      { 'i', '<F2>', [[<Cmd>lua vim.lsp.buf.rename()<CR>]] },
      { 'n', 'K', [[<Cmd>lua require('plugins/lsp/utils').hover_or_open_vim_help()<CR>]] },
      { 'n', 'gf', [[<Cmd>lua vim.lsp.buf.definition()<CR>]] },
      { 'n', ']c', ([[<Cmd>lua vim.diagnostic.goto_next(%s)<CR>]]):format(utils.table_to_string(goto_opts)) },
      { 'n', '[c', ([[<Cmd>lua vim.diagnostic.goto_prev(%s)<CR>]]):format(utils.table_to_string(goto_opts)) },
      { 'n', '<C-d>', ([[<Cmd>lua require('plugins/lsp/utils').send_key('<C-d>', %s)<CR>]]):format(bufnr) },
      { 'n', '<C-u>', ([[<Cmd>lua require('plugins/lsp/utils').send_key('<C-u>', %s)<CR>]]):format(bufnr) },
      { 'n', '<C-f>', ([[<Cmd>lua require('plugins/lsp/utils').send_key('<C-f>', %s)<CR>]]):format(bufnr) },
      { 'n', '<C-b>', ([[<Cmd>lua require('plugins/lsp/utils').send_key('<C-b>', %s)<CR>]]):format(bufnr) },
    }

    set_keymap(bufnr, maps)
  end
}

local languages = {
  eslint = function ()
    return {
      handlers = {
        ["textDocument/publishDiagnostics"] = vim.lsp.with(
          vim.lsp.diagnostic.on_publish_diagnostics, {
            signs = false,
          }
        )
      },
      on_attach = function (client, bufnr)
        set_document_formatting(client, true)

        local namespace = vim.lsp.diagnostic.get_namespace(client.id)
        local goto_opts = {
          namespace = namespace,
          float = utils.float_opts,
        }
        local maps = {
          { 'n', ']a', ([[<Cmd>lua vim.diagnostic.goto_next(%s)<CR>]]):format(utils.table_to_string(goto_opts)) },
          { 'n', '[a', ([[<Cmd>lua vim.diagnostic.goto_prev(%s)<CR>]]):format(utils.table_to_string(goto_opts)) },
          { 'n', '<F8>', [[<Cmd>lua vim.lsp.buf.formatting()<CR>]] },
        }

        set_keymap(bufnr, maps)
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
        format_on_save()
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
      handlers = {
        ["textDocument/publishDiagnostics"] = vim.lsp.with(
          vim.lsp.diagnostic.on_publish_diagnostics, {
            signs = false,
          }
        )
      },
      on_attach = function (client, bufnr)
        local namespace = vim.lsp.diagnostic.get_namespace(client.id)
        local goto_opts = {
          namespace = namespace,
          float = utils.float_opts,
        }
        local maps = {
          { 'n', ']a', ([[<Cmd>lua vim.diagnostic.goto_next(%s)<CR>]]):format(utils.table_to_string(goto_opts)) },
          { 'n', '[a', ([[<Cmd>lua vim.diagnostic.goto_prev(%s)<CR>]]):format(utils.table_to_string(goto_opts)) },
        }

        set_keymap(bufnr, maps)
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

  null_ls.config({
    diagnostics_format = '(#{c}) #{m}',
    sources = {
      null_ls.builtins.diagnostics.luacheck,
      null_ls.builtins.formatting.fixjson,
    },
  })

  local lsp_config = vim.F.npcall(languages['null-ls']) or {}
  local capabilities = get_cmp_nvim_lsp_capabilities()

  require('lspconfig')['null-ls'].setup(vim.tbl_deep_extend('force', {
    on_attach = general.on_attach,
    handlers = general.handlers,
    commands = general.commands,
    capabilities = capabilities,
  }, lsp_config))
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
end

return M
