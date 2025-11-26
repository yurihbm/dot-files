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

-- Use one statusline globally.
vim.opt.laststatus = 3
-- Hide mode information from cmdline.
vim.opt.showmode = false
-- Hide cmdline.
vim.opt.cmdheight = 0

--- Global variable for border style.
vim.g.border_style = "rounded"

-- Set border for floating windows.
vim.o.winborder = vim.g.border_style

vim.lsp.config("*", {
	-- Use the same border for LSP hover and signature help.
	border = vim.g.border_style,
})

-- Change tab size.
vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2
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

-- Set default shell to zsh in host environment when running in Flatpak
vim.opt.shell = "flatpak-spawn --host --env=TERM=xterm-256color zsh"

-- Enable window title modification
vim.opt.title = true

function _G.custom_titlestring()
	local filename = vim.fn.expand("%:t")
	local cwd = vim.fn.getcwd()
	local dirname = vim.fn.fnamemodify(cwd, ":t")

	if filename == "" then
		return dirname .. " - nvim"
	end

	-- When running flatpak-spawn, the terminal mode is used
	if vim.bo.filetype == "flatpak-spawn" then
		return "terminal - nvim"
	end

	local modified = vim.bo.modified and " [+]" or ""

	return string.format("%s%s (%s) - nvim", filename, modified, dirname)
end

vim.opt.titlestring = "%{v:lua.custom_titlestring()}"
