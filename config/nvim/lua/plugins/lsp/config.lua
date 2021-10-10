local M = {}

local function disable_formatting(client)
  client.resolved_capabilities.document_formatting = false
  client.resolved_capabilities.document_range_formatting = false
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
    local maps = {
      { 'n', '<F2>', [[<Cmd>lua vim.lsp.buf.rename()<CR>]] },
      { 'i', '<F2>', [[<Cmd>lua vim.lsp.buf.rename()<CR>]] },
      { 'n', 'K', [[<Cmd>lua require('plugins/lsp/utils').hover_or_open_vim_help()<CR>]] },
      { 'n', 'gf', [[<Cmd>lua vim.lsp.buf.definition()<CR>]] },
      { 'n', ']c', [[<Cmd>lua vim.diagnostic.goto_next({ popup_opts = { border = 'rounded', focusable = false, source = 'always' } })<CR>]] },
      { 'n', '[c', [[<Cmd>lua vim.diagnostic.goto_prev({ popup_opts = { border = 'rounded', focusable = false, source = 'always' } })<CR>]] },
      { 'n', '<C-d>', [[<Cmd>lua require('plugins/lsp/utils').send_key('<C-d>', ]] .. bufnr .. [[)<CR>]] },
      { 'n', '<C-u>', [[<Cmd>lua require('plugins/lsp/utils').send_key('<C-u>', ]] .. bufnr .. [[)<CR>]] },
      { 'n', '<C-f>', [[<Cmd>lua require('plugins/lsp/utils').send_key('<C-f>', ]] .. bufnr .. [[)<CR>]] },
      { 'n', '<C-b>', [[<Cmd>lua require('plugins/lsp/utils').send_key('<C-b>', ]] .. bufnr .. [[)<CR>]] },
    }

    set_keymap(bufnr, maps)
  end
}

local languages = {
  json = function ()
    local json_schemas = require('plugins/lsp/json_schemas')
    json_schemas.setup()

    return {
      on_attach = function (client, bufnr)
        disable_formatting(client)
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
  lua = function ()
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
  typescript = function ()
    return {
      on_attach = function (client, bufnr)
        local maps = {
          { 'n', '<F8>', [[<Cmd>lua vim.lsp.buf.formatting()<CR>]] },
        }

        set_keymap(bufnr, maps)
        disable_formatting(client)
        general.on_attach(client, bufnr)
      end,
    }
  end,
  ['null-ls'] = function ()
    return {
      on_attach = function (client, bufnr)
        local namespace = vim.lsp.diagnostic.get_namespace(client.id)
        local goto_opts = {
          namespace = namespace,
          popup_opts = {
            border = 'rounded',
            focusable = false,
            source = 'always',
          },
        }
        local maps = {
          { 'n', ']a', [[<Cmd>lua vim.diagnostic.goto_next(]] .. vim.inspect(goto_opts, { newline = '' }) .. [[)<CR>]] },
          { 'n', '[a', [[<Cmd>lua vim.diagnostic.goto_prev(]] .. vim.inspect(goto_opts, { newline = '' }) .. [[)<CR>]] },
        }

        set_keymap(bufnr, maps)
      end,
    }
  end,
}

function M.lspconfig(lang)
  require('lspinstall').setup()
  local config = vim.F.npcall(languages[lang]) or {}
  local capabilities = vim.lsp.protocol.make_client_capabilities()
  capabilities = require('cmp_nvim_lsp').update_capabilities(capabilities)

  require('lspconfig')[lang].setup(vim.tbl_deep_extend('force', {
    on_attach = general.on_attach,
    handlers = general.handlers,
    commands = general.commands,
    capabilities = capabilities,
  }, config))
end

function M.null_ls()
  local null_ls = require('null-ls')

  null_ls.config({
    diagnostics_format = '(#{c}) #{m}',
    sources = {
      null_ls.builtins.diagnostics.eslint_d,
      null_ls.builtins.diagnostics.luacheck,
      null_ls.builtins.formatting.eslint_d,
      null_ls.builtins.formatting.fixjson,
    },
  })
end

function M.completion()
  local cmp = require('cmp')

  vim.o.completeopt = 'menuone,noselect'

  cmp.setup({
    sources = {
      {
        name = 'nvim_lsp',
      },
      {
        name = 'buffer',
      },
      {
        name = 'path',
      },
    },
    snippet = {
      expand = function(args)
        vim.fn['vsnip#anonymous'](args.body)
      end,
    },
    mapping = {
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
  })
end

function M.diagnostic()
  vim.diagnostic.config({
    virtual_text = false,
    signs = false,
  })
end

return M
