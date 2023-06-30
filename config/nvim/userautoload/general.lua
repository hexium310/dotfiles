vim.cmd.language('en_US.UTF-8')
vim.opt.backspace = ''
vim.opt.cindent = true
vim.opt.expandtab = true
vim.opt.swapfile = false
vim.opt.writebackup = false
vim.opt.shiftwidth = 4
vim.opt.tabstop = 4
vim.opt.title = true
vim.opt.updatetime = 300
vim.opt.virtualedit = 'block'
vim.opt.whichwrap = ''
vim.opt.mouse = ''

vim.opt.completeopt:remove({ 'preview' })
vim.opt.cursorline = true
vim.opt.cursorlineopt = 'number'
vim.opt.diffopt:append({ 'vertical' })
vim.opt.fillchars = 'diff: ,'
vim.opt.helpheight = 0
vim.opt.lazyredraw = true
vim.opt.list = true
vim.opt.listchars = { tab = '»-', trail = '·' }
vim.opt.foldenable = false
vim.opt.showmode = false
vim.opt.wrap = false
vim.opt.number = true
vim.opt.numberwidth = 7
vim.opt.pumheight = 20
vim.opt.relativenumber = true
vim.opt.scrolloff = 2
vim.opt.shortmess:append('cs')
vim.opt.showtabline = 2
vim.opt.splitbelow = true
vim.opt.splitright = true
vim.g.loaded_matchit = true
vim.g.loaded_matchparen = true

vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.inccommand = 'split'

if vim.fn.executable('nvr') then
  vim.env.GIT_EDITOR = 'nvr --remote-tab-wait'
end

if vim.fn.executable('rg') then
  vim.opt.grepprg = 'rg --vimgrep'
  vim.opt.grepformat = '%f:%l:%c:%m'

  vim.api.nvim_create_user_command('GrepRange', function (t)
    local espaced_range = vim.fn.substitute(
      vim.fn.shellescape(
        vim.fn.join(vim.iter(vim.api.nvim_buf_get_text(0, t.line1 - 1, 0, t.line2 - 1, -1, {})):map(function (v)
          return vim.fn.escape(vim.fn.escape(v, '.+*?{}[]()^$|\\'), '|')
        end):totable(), '\\n'),
        1
      ),
      '\\!', '!', 'g'
    )

    vim.cmd.grep({ '--multiline', espaced_range, t.args or '.' })
  end, { range = true, nargs = '*' })
end

local init = vim.api.nvim_create_augroup('init', {})

vim.api.nvim_create_autocmd({ 'BufEnter', 'FileType' }, {
  group = init,
  callback = function ()
    vim.opt_local.formatoptions:remove({ 'c', 'r', 'o' })
  end,
})

vim.api.nvim_create_autocmd('BufEnter', {
  group = init,
  callback = function ()
    ---@diagnostic disable-next-line: undefined-field
    if vim.b.terminal_job_id == nil then
      vim.opt_local.winhighlight = ''
    end
  end,
})

vim.api.nvim_create_autocmd('QuickFixCmdPost', {
  group = init,
  pattern = '*grep*',
  callback = function ()
    vim.cmd.cwindow()
  end,
})

vim.api.nvim_create_autocmd('VimLeave', {
  group = init,
  callback = function ()
    vim.opt.guicursor = 'a:ver25'
  end,
})

vim.api.nvim_create_autocmd('TermOpen', {
  group = init,
  callback = function (args)
    vim.opt_local.signcolumn = 'no'
    vim.keymap.set('t', '<C-q>', '<C-\\><C-n>', {
      buffer = args.buf,
    })
  end,
})

vim.api.nvim_create_autocmd('TextYankPost', {
  group = init,
  callback = function ()
    vim.highlight.on_yank({
      higroup = 'Yanked',
      timeout = 100,
    })
  end,
})

;(function ()
  local filetypes_to_display_no_line_number = { 'toggleterm', 'man', 'DressingInput' }
  local filetypes_to_display_line_number_without_relative = { 'help' }

  local function check_filetype(filetypes)
    return vim.iter(filetypes):any(function (filetype)
      return vim.opt_local.filetype:get() == filetype
    end)
  end

  local function display_no_line_number()
    vim.opt_local.number = false
    vim.opt_local.relativenumber = false
  end

  local function display_line_number()
    vim.opt_local.number = true
    vim.opt_local.relativenumber = true
  end

  local function display_line_number_without_relative()
    vim.opt_local.number = true
    vim.opt_local.relativenumber = false
  end

  vim.api.nvim_create_autocmd({ 'BufEnter', 'InsertLeave', 'WinEnter' }, {
    group = init,
    callback = function ()
      if check_filetype(filetypes_to_display_no_line_number) then
        display_no_line_number()
      elseif check_filetype(filetypes_to_display_line_number_without_relative) then
        display_line_number_without_relative()
      else
        display_line_number()
      end
    end,
  })

  vim.api.nvim_create_autocmd({ 'BufLeave', 'InsertEnter', 'WinLeave' }, {
    group = init,
    callback = function ()
      if check_filetype(filetypes_to_display_no_line_number) then
        display_no_line_number()
      else
        display_line_number_without_relative()
      end
    end,
  })
end)()
