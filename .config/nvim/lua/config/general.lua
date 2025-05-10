-- =========================
-- General Configuration
-- =========================

-- This file provides a collection of general settings.

-- Highlight current line.
vim.opt.cursorline = true

-- Add line numbers.
vim.wo.number = true
vim.wo.relativenumber = true

-- Disable netrw.
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- Set default split directions.
vim.opt.splitright = true -- Vertical splits open on the left.
vim.opt.splitbelow = true -- Horizontal splits open at the bottom.

-- Set border for floating windows.
vim.o.winborder = "single"

vim.lsp.config("*", {
	-- Use the same border for LSP hover and signature help.
	border = "single",
})

-- Change tab size.
vim.opt.tabstop = 3
vim.opt.softtabstop = 3
vim.opt.shiftwidth = 3
vim.opt.expandtab = true

-- Change line offset.
vim.opt.scrolloff = 4

-- Set autoread on.
vim.opt.autoread = true

-- Remove mouse warning in popup menu.
vim.api.nvim_command([[aunmenu PopUp.How-to\ disable\ mouse]])
vim.api.nvim_command([[aunmenu PopUp.-1-]])

-- Set leader key.
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"
