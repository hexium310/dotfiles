local cmp = require('cmp')

-- Suppress message that _G.cmp is undefined
_G.cmp = _G.cmp

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
      require('luasnip').lsp_expand(args.body)
    end,
  },
  mapping = cmp.mapping.preset.insert({
    ['<C-b>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-x><C-n>'] = cmp.mapping.complete(),
    ['<CR>'] = cmp.mapping.abort(),
    ['<C-y>'] = cmp.mapping.confirm({
      select = true,
    }),
    ['<C-n>'] = cmp.mapping(function (fallback)
      if cmp.visible() then
        cmp.select_next_item({ behavior = require('cmp/types').cmp.SelectBehavior.Insert })
      else
        fallback()
      end
    end),
    ['<C-p>'] = cmp.mapping(function (fallback)
      if cmp.visible() then
        cmp.select_prev_item({ behavior = require('cmp/types').cmp.SelectBehavior.Insert })
      else
        fallback()
      end
    end),
  }),
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
  window = {
    documentation = cmp.config.window.bordered({
      border = 'double',
    }),
  },
  preselect = cmp.PreselectMode.None,
  experimental = {
    ghost_text = true,
  },
})

-- -- After reloading the config multiple `()`s are displayed when confirming a completion item, so reset an event listener.
-- -- event:on() returns a function to remove an event listener.
;(_G.cmp.remove_autopairs_confirm_done_event or function () end)()
_G.cmp.remove_autopairs_confirm_done_event = cmp.event:on('confirm_done', require('nvim-autopairs/completion/cmp').on_confirm_done())
