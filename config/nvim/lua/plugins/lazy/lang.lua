local languages = {
  css = {
    {
      'hail2u/vim-css3-syntax',
      ft = { 'css' },
    },
  },
  html = {
    {
      'AndrewRadev/tagalong.vim',
      ft = { 'html', 'php', 'typescriptreact' },
    },
    {
      'mattn/emmet-vim',
      ft = { 'html', 'php', 'css', 'javascript', 'typescript', 'typescriptreact' },
      init = function ()
        vim.cmd([[
          let g:user_emmet_settings = {
                \  'javascript': {
                \    'extends': 'jsx',
                \  },
                \  'typescript': {
                \    'extends': 'jsx',
                \  },
                \  'typescriptreact': {
                \    'extends': 'jsx',
                \  },
                \  'variables': {
                \    'lang': 'ja',
                \  },
                \}
          let g:user_emmet_leader_key = '<silent> <C-e>'
          imap <C-e> <Nop>
          nmap <C-e> <Nop>
          vmap <C-e> <Nop>
          const items = [
                \ {'key': ',', 'plug': 'emmet-expand-abbr'},
                \ {'key': ';', 'plug': 'emmet-expand-word'},
                \ {'key': 'u', 'plug': 'emmet-update-tag'},
                \ {'key': 'd', 'plug': 'emmet-balance-tag-inward'},
                \ {'key': 'D', 'plug': 'emmet-balance-tag-outword'},
                \ {'key': 'n', 'plug': 'emmet-move-next'},
                \ {'key': 'N', 'plug': 'emmet-move-prev'},
                \ {'key': 'i', 'plug': 'emmet-image-size'},
                \ {'key': 'I', 'plug': 'emmet-image-encode'},
                \ {'key': '/', 'plug': 'emmet-toggle-comment'},
                \ {'key': 'j', 'plug': 'emmet-split-join-tag'},
                \ {'key': 'k', 'plug': 'emmet-remove-tag'},
                \ {'key': 'a', 'plug': 'emmet-anchorize-url'},
                \ {'key': 'A', 'plug': 'emmet-anchorize-summary'},
                \ {'key': 'm', 'plug': 'emmet-merge-lines'},
          \ ]
          for item in items
            execute 'imap <silent><expr> <C-e>' . item.key . ' pumvisible() ? "\<C-y><Plug>(' . item.plug . ')" : "\<Plug>(' . item.plug . ')"'
          endfor
        ]])
      end,
    },
  },
  markdown = {
    'dhruvasagar/vim-table-mode',
    ft = { 'markdown' },
    init = function ()
      vim.g.table_mode_corner = '|'
    end,
  },
  php = {
    {
      'StanAngeloff/php.vim',
      ft = { 'php' },
    },
  },
  rust = {
    {
      'rust-lang/rust.vim',
      ft = { 'rust' },
    },
  },
  vue = {
    {
      'posva/vim-vue',
      ft = { 'vue' },
    },
  },
}

return vim.iter(languages):fold({}, function (accumulator, _, value)
  return vim.list_extend(accumulator, value)
end)
