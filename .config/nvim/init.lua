local path_package = vim.fn.stdpath('data') .. '/site'
local mini_path = path_package .. '/pack/deps/start/mini.nvim'
if not vim.loop.fs_stat(mini_path) then
  vim.cmd('echo "Installing `mini.nvim`" | redraw')
  local clone_cmd = {
    'git', 'clone', '--filter=blob:none',
    -- Uncomment next line to use 'stable' branch
    -- '--branch', 'stable',
    'https://github.com/echasnovski/mini.nvim', mini_path
  }
  vim.fn.system(clone_cmd)
  vim.cmd('packadd mini.nvim | helptags ALL')
  vim.cmd('echo "Installed `mini.nvim`" | redraw')
end
require('mini.deps').setup({ path = { package = path_package } })

local add, now, later = MiniDeps.add, MiniDeps.now, MiniDeps.later
now(function() require('mini.ai').setup() end)
now(function()
  require('mini.pick').setup() 
end)
now(function()
    
  vim.g.mapleader = ' '
  vim.g.maplocalleader = ' '
  vim.o.number = true
  vim.o.relativenumber = true
  vim.o.cursorline = true 
  vim.o.wrap = false
  vim.o.scrolloff = 10
  vim.o.sidescrolloff = 8

  vim.o.tabstop = 2
  vim.o.shiftwidth = 2
  vim.o.softtabstop = 2
  vim.o.expandtab = true
  vim.opt.smartindent = true
  vim.o.autoindent = true

  vim.o.ignorecase = true
  vim.o.smartcase = true
  vim.o.hlsearch = false
  vim.o.incsearch = true
  vim.g.have_nerd_font = true

  vim.o.termguicolors = true
  vim.o.showmatch = true
  vim.o.cmdheight = 1
  vim.o.matchtime = 2
  vim.o.completeopt = "menuone,noinsert,noselect"
  vim.o.showmode = false
  vim.o.pumheight = 10
  vim.o.pumblend = 10
  vim.o.winblend = 0
  vim.o.conceallevel = 0
  vim.o.concealcursor = ""
  vim.o.synmaxcol = 300

  vim.o.backup = false
  vim.o.writebackup = false
  vim.o.swapfile = false
  vim.o.undofile = true
  vim.o.undodir = vim.fn.expand("~/.vim/undodir")
  vim.o.updatetime = 300
  vim.o.timeoutlen = 500
  vim.o.ttimeoutlen = 0
  vim.o.autoread = true
  vim.o.autowrite = false
  vim.o.clipboard = "unnamedplus"
  vim.o.hidden = true
  vim.o.errorbells = false
  vim.o.backspace = "indent,eol,start"
  vim.o.autochdir = false

  -- Split
  vim.keymap.set('n', '<leader>s', ':split<CR>', { desc = 'Split horizontally' })
  vim.keymap.set('n', '<leader>v', ':vsplit<CR>', { desc = 'Split vertically' })

  -- Navigation
  vim.keymap.set('n', '<C-h>', '<C-w>h', { desc = 'Move to left split' })
  vim.keymap.set('n', '<C-j>', '<C-w>j', { desc = 'Move to split below' })
  vim.keymap.set('n', '<C-k>', '<C-w>k', { desc = 'Move to split above' })
  vim.keymap.set('n', '<C-l>', '<C-w>l', { desc = 'Move to right split' })

  -- Resizing
  --
  vim.keymap.set('n', '<leader>+', ':resize +2<CR>', { desc = 'Increase height' })
  vim.keymap.set('n', '<leader>-', ':resize -2<CR>', { desc = 'Decrease height' })
  vim.keymap.set('n', '<leader>>', ':vertical resize +2<CR>', { desc = 'Increase width' })
  vim.keymap.set('n', '<leader><', ':vertical resize -2<CR>', { desc = 'Decrease width' })
  vim.keymap.set('n', '<leader>=', '<C-w>=', { desc = 'Equal splits' }) 

  vim.keymap.set('v', '<', '<gv', { desc = 'Indent left and reselect'})
  vim.keymap.set('v', '>', '>gv', { desc = 'Indent right and reselect'})

  vim.keymap.set('n', '<leader>ff', function()
    require('mini.pick').builtin.files()
  end, {desc = 'Find files'})
  vim.keymap.set('n', '<leader>fb', function()
    require('mini.pick').builtin.buffers()
  end, { desc = '[F]ind [B]uffers'})
  vim.keymap.set('n', '<leader>fr', function()
    require('mini.pick').builtin.resume()
  end, {desc = '[R]esume'})
end)
