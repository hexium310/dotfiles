local cmp = require('cmp')
local set_keymaps = require('plugins.utils').set_keymaps

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
  mapping = cmp.mapping.preset.insert({
    ['<C-b>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-x><C-n>'] = cmp.mapping.complete(),
    ['<CR>'] = cmp.mapping.confirm({
      select = true,
      behavior = cmp.ConfirmBehavior.Insert,
    }),
    ['<C-y>'] = cmp.mapping.confirm({
      select = true,
      behavior = cmp.ConfirmBehavior.Replace,
    }),
    ['<C-n>'] = cmp.mapping(function (fallback)
      if cmp.visible() then
        cmp.select_next_item({ behavior = require('cmp.types').cmp.SelectBehavior.Select })
      else
        fallback()
      end
    end),
    ['<C-p>'] = cmp.mapping(function (fallback)
      if cmp.visible() then
        cmp.select_prev_item({ behavior = require('cmp.types').cmp.SelectBehavior.Select })
      else
        fallback()
      end
    end),
  }),
  ---@diagnostic disable-next-line: missing-fields
  formatting = {
    format = function (entry, vim_item)
      local lsp_menu = '[LSP]'

      local filetype = entry.context.filetype
      local detail = entry.completion_item.labelDetails and entry.completion_item.labelDetails.detail
      local description = entry.completion_item.labelDetails and entry.completion_item.labelDetails.description
      if detail then
        local pattern = ''
        if filetype == 'rust' then
          pattern = ' %((use .+)%)'

          entry.completion_item.detail = detail:gsub(pattern, '%1')
        end

        lsp_menu = detail:gsub(pattern, "%1"):sub(1, 40)
      elseif description then
        lsp_menu = description:sub(1, 40)
      end

      vim_item.menu = ({
        nvim_lsp = lsp_menu,
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

local maps = {
  { { 'i', 's' }, '<Tab>', function ()
    if vim.snippet.active({ direction = 1 }) then
      return '<Cmd>lua vim.snippet.jump(1)<CR>'
    else
      return '<Tab>'
    end
  end },
  { { 'i', 's' }, '<S-Tab>', function ()
    if vim.snippet.active({ direction = -1 }) then
      return '<Cmd>lua vim.snippet.jump(-1)<CR>'
    else
      return '<Tab>'
    end
  end },
}

set_keymaps(maps, {
  silent = true,
  expr = true,
})

-- -- After reloading the config multiple `()`s are displayed when confirming a completion item, so reset an event listener.
-- -- event:on() returns a function to remove an event listener.
;(_G.cmp and _G.cmp.remove_autopairs_confirm_done_event or function () end)()
local option = {
  filetypes = {
    rust = false,
  },
}
_G.cmp = {
  remove_autopairs_confirm_done_event = cmp.event:on('confirm_done', require('nvim-autopairs.completion.cmp').on_confirm_done(option))
}
