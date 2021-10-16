local M = {}

--- @param cmd string | string[]
--- @param opts table
--- @return string @Raw data
local function job(cmd, opts)
  local result = {}
  local job_id = vim.fn.jobstart(cmd, vim.tbl_extend('force', {
    on_stdout = function (_, data)
      result = table.concat(data, '')
    end,
    stdout_buffered = true,
  }, opts or {}))

  vim.fn.jobwait({ job_id }, 10000)
  vim.fn.jobstop(job_id)

  return result
end

--- @param server Server
--- @return table @JSON
local function npm(server)
  return vim.fn.json_decode(job({
    'npm',
    'outdated',
    '--json',
  }, {
    cwd = server.root_dir,
  }))
end

--- @param repo string
--- @return table @JSON
local function github_release(repo)
  return vim.fn.json_decode(job({
    'curl',
    '-s',
    string.format('https://api.github.com/repos/%s/releases/latest', repo),
  }))
end

--- @param json table
--- @return table
local function build_npm_results(json)
  local results = {}

  for package, info in pairs(json) do
    results = vim.tbl_extend('error', results, {
      [package] = {
        current_version = info.current,
        latest_version = info.latest,
      },
    })
  end

  return results
end

local languages = {
  json = function (server)
    return build_npm_results(npm(server))
  end,
  lua = function (server)
    local current_version = vim.fn.json_decode(vim.fn.readfile(server.root_dir .. '/sumneko-lua/extension/package.json')).version
    local latest_version = string.match(github_release('sumneko/vscode-lua').tag_name, '%d+%.%d+%.%d+')

    return {
      ['vscode-lua'] = {
        current_version = current_version,
        latest_version = latest_version,
      },
    }
  end,
  rust = function (server)
    local current_version = vim.split(job({
      server.root_dir .. '/rust-analyzer',
      '--version',
    }), ' ')[3]
    local latest_version = github_release('rust-analyzer/rust-analyzer').tag_name

    return {
      ['rust-analyzer'] = {
        current_version = current_version,
        latest_version = latest_version,
      },
    }
  end,
  tailwindcss = function (server)
    return build_npm_results(npm(server))
  end,
  tsserver = function (server)
    return build_npm_results(npm(server))
  end,
  yamlls = function (server)
    return build_npm_results(npm(server))
  end,
  vimls = function (server)
    return build_npm_results(npm(server))
  end,
}

function M.check_update()
  local update_available_servers = {}

  for _, server in ipairs(require('nvim-lsp-installer').get_installed_servers()) do
    local name = server.name
    local func = languages[name]

    if type(func) == 'function' then
      local update_available_packages = {}

      for package, value in pairs(func(server)) do
        if value.current_version ~= value.latest_version then
          update_available_packages = vim.tbl_extend('error', update_available_packages, {
            [package] = value,
          })
        end
      end

      if not vim.tbl_isempty(update_available_packages) then
        update_available_servers = vim.tbl_extend('error', update_available_servers, {
          [server.name] = update_available_packages,
        })
      end
    end
  end

  return update_available_servers
end

return M
