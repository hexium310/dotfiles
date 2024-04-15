local channel_id = vim.fn.sockconnect('pipe', vim.env.NVIM, { rpc = true })
vim.rpcrequest(channel_id, 'nvim_exec_lua', [[
  local args = ...
  vim.cmd.tabedit()
  vim.api.nvim_buf_set_lines(0, 0, -1, false, vim.split(args.stdin, "\n", { plain = true }))
  vim.cmd('Man!')
]], { {
  stdin = io.stdin:read("*a"):gsub("\n$", "")
} })
vim.fn.chanclose(channel_id)
