local actions = {
  init = [[
    local buffers = vim.iter(vim.fn.getbufinfo()):filter(function (buffer) return vim.tbl_get(buffer, 'variables', 'terminal_job_id') ~= nil end)
    local lastused_buffer = buffers:fold({ lastused = 0 }, function (accumulator, value)
      return value.lastused > accumulator.lastused and value or accumulator
    end)
    return lastused_buffer.bufnr
  ]],
  cd = [[
    local args = ...
    if args.buffer_id == nil then
      return
    end

    vim.api.nvim_buf_set_var(tonumber(args.buffer_id), 'terminal_current_directory', args.directory)
    vim.cmd.redrawstatus()
  ]]
}

local channel_id = vim.fn.sockconnect('pipe', vim.env.NVIM, { rpc = true })
local result = vim.rpcrequest(channel_id, 'nvim_exec_lua', actions[_G.arg[1]], { {
  buffer_id = vim.env._NVIM_TERMINAL_BUFFER_ID,
  directory = vim.env.PWD,
} })
vim.fn.chanclose(channel_id)

if result ~= nil then
  io.stdout:write(tostring(result))
end
