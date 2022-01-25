if _G.cmp.remove_autopairs_confirm_done_event == nil then
  _G.cmp.remove_autopairs_confirm_done_event = function ()
  end
end

local function init()
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

  _G.cmp.remove_autopairs_confirm_done_event()
  _G.cmp.remove_autopairs_confirm_done_event = cmp.event:on('confirm_done', require('nvim-autopairs/completion/cmp').on_confirm_done())
end

return init
