local function init()
  require('Comment').setup({
    pre_hook = function()
      -- Don't use `/` as delimieter
      return require('ts_context_commentstring.internal').calculate_commentstring()
    end
  })
end

return init
