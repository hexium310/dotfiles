local M = {
  language_configs = {
    lua = function ()
      local runtime_path = vim.split(package.path, ';')
      table.insert(runtime_path, "?.lua")
      table.insert(runtime_path, "?/init.lua")

      return {
        Lua = {
          hover = {
            previewFields = 100
          },
          completion = {
            requireSeparator = '/'
          },
          runtime = {
            version = 'LuaJIT',
            path = runtime_path,
          },
          diagnostics = {
            globals = { 'vim' },
          },
          workspace = {
            library = vim.api.nvim_get_runtime_file('lua/', true)
          },
        },
      }
    end,
    json = function ()
      local json_schemas = require('plugins/lsp/json_schemas')
      json_schemas.setup()

      return {
        json = {
          schemas = json_schemas.decode().schemas
        }
      }
    end
  },
  handlers = {
    ["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
      border = 'rounded',
      focusable = false,
    }),
    ["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
      border = 'rounded',
      silent = true,
      focusable = false,
    }),
    ["textDocument/publishDiagnostics"] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
      virtual_text = false,
      signs = false,
    }),
  },
}

function M.lspconfig(lang)
  require('lspinstall').setup()
  local settings = vim.F.npcall(M.language_configs[lang]) or {}
  local capabilities = vim.lsp.protocol.make_client_capabilities()
  capabilities = require('cmp_nvim_lsp').update_capabilities(capabilities)

  require('lspconfig')[lang].setup({
    on_attach = M.on_attach,
    handlers = M.handlers,
    settings = settings,
    capabilities = capabilities,
  })
end

function M.on_attach(client, bufnr)
  local maps = {
    { 'n', '<F2>', [[<Cmd>lua vim.lsp.buf.rename()<CR>]] },
    { 'i', '<F2>', [[<Cmd>lua vim.lsp.buf.rename()<CR>]] },
    { 'n', 'K', [[<Cmd>lua require('plugins/lsp/utils').hover_or_open_vim_help()<CR>]] },
    { 'n', 'gf', [[<Cmd>lua vim.lsp.buf.definition()<CR>]] },
    { 'n', ']c', [[<Cmd>lua vim.lsp.diagnostic.goto_next({ popup_opts = { border = 'rounded', focusable = false } })<CR>]] },
    { 'n', '[c', [[<Cmd>lua vim.lsp.diagnostic.goto_prev({ popup_opts = { border = 'rounded', focusable = false } })<CR>]] },
    { 'n', '<C-d>', [[<Cmd>lua require('plugins/lsp/utils').send_key('<C-d>', ]] .. bufnr .. [[)<Cr>]] },
    { 'n', '<C-u>', [[<Cmd>lua require('plugins/lsp/utils').send_key('<C-u>', ]] .. bufnr .. [[)<Cr>]] },
    { 'n', '<C-f>', [[<Cmd>lua require('plugins/lsp/utils').send_key('<C-f>', ]] .. bufnr .. [[)<Cr>]] },
    { 'n', '<C-b>', [[<Cmd>lua require('plugins/lsp/utils').send_key('<C-b>', ]] .. bufnr .. [[)<Cr>]] },
  }

  for _, v in ipairs(maps) do
    local mode = v[1]
    local lhs = v[2]
    local rhs = v[3]

    vim.api.nvim_buf_set_keymap(bufnr, mode, lhs, rhs, { noremap = true, silent = true })
  end
end

function M.completion()
  local cmp = require('cmp')

  vim.o.completeopt = 'menuone,noselect'

  cmp.setup({
    sources = {
      {
        name = 'nvim_lsp'
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
        vim.fn["vsnip#anonymous"](args.body)
      end,
    },
    mapping = {
      ['<C-x><C-n>'] = cmp.mapping.complete(),
      ['<C-y>'] = cmp.mapping.confirm({
        select = true,
      })
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
      border = 'single'
    },
  })
end

return M
