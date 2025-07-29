vim.o.number = true
vim.o.relativenumber = true
vim.g.mapleader = ' '
vim.g.maplocalleader = ' ' 
vim.g.have_nerd_font = true

vim.keymap.set('n', '<leader>|', ':vsplit<CR>', { desc = "Split vertically" })
vim.keymap.set('n', '<leader>/', ':split<CR>', { desc = "Split horizontally" })
