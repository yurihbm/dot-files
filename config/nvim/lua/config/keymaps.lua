-- =========================
-- Keymaps
-- =========================

-- This file provides a collection of keymaps for various modes.

local del = vim.keymap.del
local keymap = vim.keymap.set
local opts = { noremap = true, silent = true }

-- =========================
-- LSP Keymaps
-- =========================
keymap("n", "gn", vim.lsp.buf.rename, vim.tbl_extend("force", opts, { desc = "Rename" }))
keymap("n", "ga", vim.lsp.buf.code_action, vim.tbl_extend("force", opts, { desc = "Show Code Actions" }))
keymap("n", "gO", vim.lsp.buf.definition, vim.tbl_extend("force", opts, { desc = "Show Symbol Usage" }))
keymap("n", "gd", vim.lsp.buf.definition, vim.tbl_extend("force", opts, { desc = "Go to Definition" }))
keymap("n", "gh", function()
	vim.cmd("split")
	vim.lsp.buf.definition()
end, vim.tbl_extend("force", opts, { desc = "Go to Definition (split)" }))
keymap("n", "gv", function()
	vim.cmd("vsplit")
	vim.lsp.buf.definition()
end, vim.tbl_extend("force", opts, { desc = "Go to Definition (vsplit)" }))

-- =========================
-- Intuitive Split Resizing Keymaps
-- =========================
keymap("n", "<C-Up>", function()
	if vim.fn.winnr("j") == vim.fn.winnr() then
		vim.cmd("resize +2")
	else
		vim.cmd("resize -2")
	end
end, vim.tbl_extend("force", opts, { desc = "Resize Split Up" }))
keymap("n", "<C-Down>", function()
	if vim.fn.winnr("j") == vim.fn.winnr() then
		vim.cmd("resize -2")
	else
		vim.cmd("resize +2")
	end
end, vim.tbl_extend("force", opts, { desc = "Resize Split Down" }))
keymap("n", "<C-Left>", function()
	if vim.fn.winnr("l") == vim.fn.winnr() then
		vim.cmd("vertical resize +2")
	else
		vim.cmd("vertical resize -2")
	end
end, vim.tbl_extend("force", opts, { desc = "Resize Split Left" }))
keymap("n", "<C-Right>", function()
	if vim.fn.winnr("l") == vim.fn.winnr() then
		vim.cmd("vertical resize -2")
	else
		vim.cmd("vertical resize +2")
	end
end, vim.tbl_extend("force", opts, { desc = "Resize Split Right" }))

-- =========================
-- Clipboard Keymaps
-- =========================
keymap("v", "<leader>y", '"+y', vim.tbl_extend("force", opts, { desc = "Copy to System Clipboard" }))
keymap("n", "<leader>p", '"+p', vim.tbl_extend("force", opts, { desc = "Paste from System Clipboard" }))

-- =========================
-- Delete Unused Default Keymaps
-- =========================
del("n", "grt")
del("n", "grr")
del("n", "gri")
del("n", "gra")
del("n", "grn")
