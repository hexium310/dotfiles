local utils = require('plugins.utils')

require('blink.cmp').setup({
  keymap = {
    preset = 'default',
  },
  completion = {
    keyword = {
      range = 'full',
    },
    trigger = {
      show_on_backspace = true,
    },
    list = {
      selection = {
        preselect = false,
        auto_insert = false,
      },
    },
    menu = {
      auto_show_delay_ms = 100,
      max_height = math.floor(vim.o.lines * 0.4),
      border = 'none',
      draw = {
        columns = {
          { 'kind_icon' },
          { 'label', 'label_description', gap = 1 },
          { 'label_detail_or_source_name' },
        },
        components = {
          label = {
            text = function(ctx)
              return ctx.label
            end,
          },
          label_detail_or_source_name = {
            text = function (ctx)
              if ctx.source_id == 'lsp' then
                if ctx.label_detail ~= "" then
                  return ctx.label_detail
                else
                    return ("[%s]") :format(ctx.item.client_name)
                end
              end

              return ("[%s]") :format(ctx.source_name)
            end,
            highlight = 'BlinkCmpLabelDescription',
          },
        },
      },
    },
    documentation = {
      auto_show = true,
      window = {
        border = 'double',
        max_height = math.floor(vim.o.lines * 0.4),
        max_width = math.floor(vim.o.columns * 0.5),
      },
    },
    ghost_text = {
      enabled = true,
    },
  },
  appearance = {
    use_nvim_cmp_as_default = true,
    nerd_font_variant = 'normal',
  },
  cmdline = {
    keymap = {
      ['<CR>'] = { 'accept_and_enter', 'fallback' },
      ['<Down>'] = { 'select_next', 'fallback' },
      ['<Up>'] = { 'select_prev', 'fallback' }
    },
  },
})

utils.set_keymaps({
  { 'i', '<C-x><C-n>' , function () require('blink.cmp').show() end }
}, {})
