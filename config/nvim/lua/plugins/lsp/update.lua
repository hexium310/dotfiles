local M = {}

local lsp_install_path = require('lspinstall/util').install_path

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

--- @param lang string
--- @param packages string[]
--- @return table @JSON
local function npm(lang, packages)
  return vim.fn.json_decode(job(vim.list_extend({
    'npm',
    'outdated',
    '--json',
  }, packages), {
    cwd = lsp_install_path(lang),
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
  json = function ()
    local current_version = vim.fn.json_decode(vim.fn.readfile(lsp_install_path('json') .. '/vscode-json/json-language-features/server/package.json')).version
    local tag_name = github_release('microsoft/vscode').tag_name
    local latest_version = vim.fn.json_decode(job({
      'curl',
      '-s',
      string.format('https://raw.githubusercontent.com/microsoft/vscode/%s/extensions/json-language-features/server/package.json', tag_name),
    })).version

    return {
      ['json-language-features'] = {
        current_version = current_version,
        latest_version = latest_version,
      },
    }
  end,
  lua = function ()
    local current_version = vim.fn.json_decode(vim.fn.readfile(lsp_install_path('lua') .. '/sumneko-lua/extension/package.json')).version
    local latest_version = string.match(github_release('sumneko/vscode-lua').tag_name, '%d+%.%d+%.%d+')

    return {
      ['vscode-lua'] = {
        current_version = current_version,
        latest_version = latest_version,
      },
    }
  end,
  rust = function ()
    local current_version = vim.split(job({
      lsp_install_path('rust') .. '/rust-analyzer',
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
  tailwindcss = function ()
    return build_npm_results(npm('tailwindcss', { '@tailwindcss/language-server' }))
  end,
  typescript = function ()
    return build_npm_results(npm('typescript', { 'typescript-language-server', 'typescript' }))
  end,
  yaml = function ()
    return build_npm_results(npm('yaml', { 'yaml-language-server' }))
  end,
  vim = function ()
    return build_npm_results(npm('vim', { 'vim-language-server' }))
  end,
}

function M.check_update()
  local installed_servers = require('lspinstall').installed_servers()
  local update_available_servers = {}
  for _, server in ipairs(vim.tbl_filter(function (v) return type(languages[v]) == 'function' end, installed_servers)) do
    local update_available_packages = {}

    for package, value in pairs(languages[server]()) do
      if value.current_version ~= value.latest_version then
        update_available_packages = vim.tbl_extend('error', update_available_packages, {
          [package] = value,
        })
      end
    end

    if not vim.tbl_isempty(update_available_packages) then
      update_available_servers = vim.tbl_extend('error', update_available_servers, {
        [server] = update_available_packages,
      })
    end
  end

  return update_available_servers
end

return M
