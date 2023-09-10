return {
  {
    'AndrewRadev/tagalong.vim',
    ft = { 'html', 'php', 'typescriptreact' },
  },
  {
    'mattn/emmet-vim',
    ft = { 'html', 'php', 'css', 'javascript', 'typescript', 'typescriptreact' },
    init = function ()
      vim.g.user_emmet_settings = {
        javascript = {
          extends = 'jsx',
        },
        typescript = {
          extends = 'jsx',
        },
        typescriptreact = {
          extends = 'jsx',
        },
        variables = {
          lang = 'ja',
        },
      }
      vim.g.user_emmet_leader_key = '<silent> <C-e>'
      vim.keymap.set({ 'i', 'n', 'v' }, '<C-e>', '<Nop>')
      local items = {
        { key = ',', plug = 'emmet-expand-abbr' },
        { key = ';', plug = 'emmet-expand-word' },
        { key = 'u', plug = 'emmet-update-tag' },
        { key = 'd', plug = 'emmet-balance-tag-inward' },
        { key = 'D', plug = 'emmet-balance-tag-outword' },
        { key = 'n', plug = 'emmet-move-next' },
        { key = 'N', plug = 'emmet-move-prev' },
        { key = 'i', plug = 'emmet-image-size' },
        { key = 'I', plug = 'emmet-image-encode' },
        { key = '/', plug = 'emmet-toggle-comment' },
        { key = 'j', plug = 'emmet-split-join-tag' },
        { key = 'k', plug = 'emmet-remove-tag' },
        { key = 'a', plug = 'emmet-anchorize-url' },
        { key = 'A', plug = 'emmet-anchorize-summary' },
        { key = 'm', plug = 'emmet-merge-lines' },
      }
      vim.iter(items):each(function(item)
        vim.keymap.set('i', '<C-e>' .. item.key, function ()
          local plug = '<Plug>(' .. item.plug .. ')'
          return vim.fn.pumvisible() and '<C-y>' .. plug or plug
        end, { silent = true, expr = true })
      end)
    end,
  },
}
