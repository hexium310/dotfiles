local function init()
  require('Comment').setup({
    pre_hook = function(ctx)
      if vim.tbl_contains({ 'toml', 'vim' }, vim.bo.filetype) then
        local type = ctx.ctype == require('Comment.utils').ctype.line and '__default' or '__multiline'
        -- Don't use `/` as delimieter
        return require('ts_context_commentstring.internal').calculate_commentstring({
          key = type
        })
      end
    end
  })
end

return init
