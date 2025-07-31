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
require('mini.snippets').setup()
require('mini.surround').setup()
require('mini.completion').setup()
require('mini.files').setup()
local add, now, later = MiniDeps.add, MiniDeps.now, MiniDeps.later
now(function() require('mini.ai').setup() end)
add({ source = 'Shatur/neovim-ayu' })
add({ source = 'neovim/nvim-lspconfig' })
now(function()
  require('mini.pick').setup()
end)
now(function()
  require('ayu').setup({
    mirage = false,
    overrides = {}
  })
  vim.cmd('colorscheme ayu-mirage')
  local orig_util_open_floating_preview = vim.lsp.util.open_floating_preview
  function vim.lsp.util.open_floating_preview(contents, syntax, opts, ...)
    opts = opts or {}
    opts.border = opts.border or 'single'
    opts.max_width = opts.max_width or 60 -- Set your desired max width here
    return orig_util_open_floating_preview(contents, syntax, opts, ...)
  end

  vim.api.nvim_create_autocmd('LspAttach', {
    desc = 'LSP actions',
    callback = function(event)
      local opts = { buffer = event.buf }

      local client = vim.lsp.get_client_by_id(event.data.client_id)
      if not client then return end

      if client.supports_method('textDocument/formatting') then
        vim.keymap.set('n', '<leader>fw', function()
          vim.lsp.buf.format({ async = false, buffer = event.buffer, id = client.id })
          vim.cmd('w')
        end, { desc = 'Format and Save' })
      end
      -- vim.api.nvim_create_autocmd('BufWritePre', {
      --   buffer = event.buf,
      --   callback = function()
      --     vim.lsp.buf.format({ bufnr = event.buffer, id = client.id })
      --   end,
      -- })
      -- end
      vim.keymap.set('n', 'K', '<cmd>lua vim.lsp.buf.hover()<cr>', opts)
      vim.keymap.set('i', '<C-s>', '<cmd>lua vim.lsp.buf.signature_help()<cr>', opts)
      vim.keymap.set('n', '<leader>gi', '<cmd>lua vim.lsp.buf.implementation()<cr>', opts)
      vim.keymap.set('n', '<leader>gt', '<cmd>lua vim.lsp.buf.type_definition()<cr>', opts)
      vim.keymap.set('n', '<leader>gr', '<cmd>lua vim.lsp.buf.references()<cr>', opts)
      vim.keymap.set('n', '<leader>gn', '<cmd>lua vim.lsp.buf.rename()<cr>', opts)
      vim.keymap.set('n', '<leader>ga', '<cmd>lua vim.lsp.buf.code_action()<cr>', opts)
      vim.keymap.set('n', '<leader>e', '<cmd>lua vim.diagnostic.open_float()<cr>',
        { buffer = event.buf, desc = 'Show diagnostics' })
    end,
  })
  vim.lsp.enable('lua_ls')
  vim.lsp.enable('astro')
  vim.lsp.enable('eslint')
  vim.lsp.enable('ts_ls')
  vim.lsp.enable('emmet_language_server')
  -- vim.lsp.enable('emmet_ls')
  vim.lsp.enable('gopls')
  vim.opt.completeopt = { 'menu', 'menuone', 'noselect' }
  vim.cmd([[
    highlight Normal guibg=NONE ctermbg=NONE
    highlight NonText guibg=NONE ctermbg=NONE
    highlight LineNr guibg=NONE ctermbg=NONE
    highlight Folded guibg=NONE ctermbg=NONE
    highlight EndOfBuffer guibg=NONE ctermbg=NONE
    highlight SignColumn guibg=NONE ctermbg=NONE
    "highlight CursorLine guibg=NONE ctermbg=NONE
    "highlight CursorColumn guibg=NONE ctermbg=NONE
    highlight ColorColumn guibg=NONE ctermbg=NONE
    highlight NormalFloat guibg=NONE ctermbg=NONE
    highlight FloatBorder guibg=NONE ctermbg=NONE
  ]])
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
  vim.o.autoindent = true

  vim.o.ignorecase = true
  vim.o.smartcase = true
  vim.o.hlsearch = false
  vim.o.incsearch = true
  vim.g.have_nerd_font = true

  vim.o.termguicolors = true
  vim.o.showmatch = true
  vim.o.showmode = false
  vim.o.pumheight = 10
  vim.o.pumblend = 10

  vim.o.backup = false
  vim.o.writebackup = false
  vim.o.swapfile = false
  vim.o.undofile = true
  vim.o.undodir = vim.fn.expand("~/.vim/undodir")
  vim.o.autoread = true
  vim.o.autowrite = false
  vim.o.clipboard = "unnamed,unnamedplus"
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

  vim.keymap.set('v', '<', '<gv', { desc = 'Indent left and reselect' })
  vim.keymap.set('v', '>', '>gv', { desc = 'Indent right and reselect' })

  vim.keymap.set('n', '<leader>j', '<C-d>zz', { desc = 'Jump half page and center cursor' })
  vim.keymap.set('n', '<leader>k', '<C-u>zz', { desc = 'Jump half page and center cursor' })
  vim.keymap.set('n', '<leader>ff', function()
    require('mini.pick').builtin.files()
  end, { desc = 'Find files' })
  vim.keymap.set('n', '<leader>fb', function()
    require('mini.pick').builtin.buffers()
  end, { desc = '[F]ind [B]uffers' })
  vim.keymap.set('n', '<leader>fr', function()
    require('mini.pick').builtin.resume()
  end, { desc = '[R]esume' })
  vim.keymap.set('n', '<leader>/', function() 
    require('mini.pick').builtin.grep_live()
  end, { desc = 'Live search' })
  vim.keymap.set('n', '<leader>t', function()
    require('mini.files').open()
  end, { desc = 'Open Mini files explorer' })
end)
