vim.env.GIT_EDITOR = require('waitevent').editor({
  -- Prevents the terminal window closing
  on_done = function (_)
  end,
})

vim.env.EDITOR = require('waitevent').editor({
  done_events = {},
  cancel_events = {},
})
