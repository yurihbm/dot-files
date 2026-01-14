-- =========================
-- General Configuration
-- =========================

-- This file provides a collection of general settings.

-- Highlight current line.
vim.opt.cursorline = true

-- Add line numbers.
vim.wo.number = true
vim.wo.relativenumber = true

-- Set a shorter update time for better responsiveness.
vim.opt.updatetime = 750

-- Ignore node_modules in file navigation and completion.
vim.opt.wildignore:append({ "*/node_modules/**" })

-- Set default split directions.
vim.opt.splitright = true -- Vertical splits open on the left.
vim.opt.splitbelow = true -- Horizontal splits open at the bottom.

-- Undo persistence
vim.opt.undofile = true
vim.opt.undodir = vim.fn.stdpath("state") .. "/undo"

-- Search improvements
vim.opt.ignorecase = true -- Ignore case
vim.opt.smartcase = true -- ...unless uppercase letters are used
vim.opt.hlsearch = true -- Highlight search results
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")

-- Sync with system clipboard.
vim.opt.clipboard = "unnamedplus"

--- Global variable for border style.
vim.g.border_style = "single"

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

-- Enable window title modification
vim.opt.title = true

-- netrw settings
vim.g.netrw_banner = 0
vim.g.netrw_liststyle = 3
vim.g.netrw_keepdir = 0

function _G.custom_titlestring()
	local filename = vim.fn.expand("%:t")
	local cwd = vim.fn.getcwd()
	local dirname = vim.fn.fnamemodify(cwd, ":t")

	if filename == "" then
		return dirname .. " - nvim"
	end

	local modified = vim.bo.modified and " [+]" or ""

	return string.format("%s%s (%s) - nvim", filename, modified, dirname)
end

vim.opt.titlestring = "%{v:lua.custom_titlestring()}"
