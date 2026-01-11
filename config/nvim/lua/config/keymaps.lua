-- =========================
-- Keymaps
-- =========================

-- This file provides a collection of keymaps for various modes.

local keymap = vim.keymap.set
local opts = { noremap = true, silent = true }

-- =========================
-- LSP Keymaps
-- =========================
keymap("n", "gd", vim.lsp.buf.definition, vim.tbl_extend("force", opts, { desc = "[G]o to [D]efinition" }))
keymap("n", "gh", function()
	vim.cmd("split")
	vim.lsp.buf.definition()
end, vim.tbl_extend("force", opts, { desc = "[G]o to Definition ([H]orizontal Split)" }))
keymap("n", "gv", function()
	vim.cmd("vsplit")
	vim.lsp.buf.definition()
end, vim.tbl_extend("force", opts, { desc = "[G]o to Definition ([V]ertical Split)" }))

-- =========================
-- Clipboard Keymaps
-- =========================
keymap("v", "<leader>y", '"+y', vim.tbl_extend("force", opts, { desc = "Cop[y] to System Clipboard" }))
keymap("n", "<leader>p", '"+p', vim.tbl_extend("force", opts, { desc = "[P]aste from System Clipboard" }))
