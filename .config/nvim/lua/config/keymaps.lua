-- =========================
-- Keymaps
-- =========================

-- This file provides a collection of keymaps for various modes.

local keymap = vim.keymap.set
local opts = { noremap = true, silent = true }

-- =========================
-- LSP Keymaps
-- =========================
keymap("n", "<leader>rn", vim.lsp.buf.rename, vim.tbl_extend("force", opts, { desc = "Rename" }))
keymap("i", "<C-r>", vim.lsp.buf.rename, vim.tbl_extend("force", opts, { desc = "Rename (insert mode)" }))
keymap("n", "<leader>gd", vim.lsp.buf.definition, vim.tbl_extend("force", opts, { desc = "Go to definition" }))
keymap("i", "<C-g>", vim.lsp.buf.definition, vim.tbl_extend("force", opts, { desc = "Go to definition (insert mode)" }))
keymap("n", "<leader>gx", function()
	vim.cmd("split")
	vim.lsp.buf.definition()
end, vim.tbl_extend("force", opts, { desc = "Go to definition (split)" }))
keymap("n", "<leader>gv", function()
	vim.cmd("vsplit")
	vim.lsp.buf.definition()
end, vim.tbl_extend("force", opts, { desc = "Go to definition (vsplit)" }))
keymap("n", "<leader>h", vim.lsp.buf.hover, vim.tbl_extend("force", opts, { desc = "Hover information" }))
keymap("n", "<leader>d", vim.diagnostic.open_float, vim.tbl_extend("force", opts, { desc = "Diagnostic information" }))
keymap("n", "<leader>ca", vim.lsp.buf.code_action, vim.tbl_extend("force", opts, { desc = "Code actions" }))
keymap("i", "<C-a>", vim.lsp.buf.code_action, vim.tbl_extend("force", opts, { desc = "Code actions (insert mode)" }))
-- Disable default hover keymap.
keymap("n", "K", "<Nop>", { noremap = true, silent = true })

-- =========================
-- Movement Keymaps (Insert/Command mode)
-- =========================
-- Insert mode
keymap("i", "<C-h>", "<Left>", { desc = "Move left" })
keymap("i", "<C-j>", "<Down>", { desc = "Move down" })
keymap("i", "<C-k>", "<Up>", { desc = "Move up" })
keymap("i", "<C-l>", "<Right>", { desc = "Move right" })
-- Command mode
keymap("c", "<C-h>", "<Left>", { desc = "Move left (command mode)" })
keymap("c", "<C-j>", "<Down>", { desc = "Move down (command mode)" })
keymap("c", "<C-k>", "<Up>", { desc = "Move up (command mode)" })
keymap("c", "<C-l>", "<Right>", { desc = "Move right (command mode)" })

-- =========================
-- Split Resizing Keymaps
-- =========================
keymap("n", "<C-Up>", function()
	vim.cmd("resize " .. (vim.fn.winheight(0) - 2))
end, vim.tbl_extend("force", opts, { desc = "Resize split up" }))
keymap("n", "<C-Down>", function()
	vim.cmd("resize " .. (vim.fn.winheight(0) + 2))
end, vim.tbl_extend("force", opts, { desc = "Resize split down" }))
keymap("n", "<C-Left>", function()
	vim.cmd("vertical resize " .. (vim.fn.winwidth(0) - 2))
end, vim.tbl_extend("force", opts, { desc = "Resize split left" }))
keymap("n", "<C-Right>", function()
	vim.cmd("vertical resize " .. (vim.fn.winwidth(0) + 2))
end, vim.tbl_extend("force", opts, { desc = "Resize split right" }))

-- =========================
-- Clipboard Keymaps
-- =========================
keymap("v", "<leader>y", '"+y', vim.tbl_extend("force", opts, { desc = "Copy to clipboard" }))
keymap("n", "<leader>p", '"+p', vim.tbl_extend("force", opts, { desc = "Paste from clipboard" }))

-- =========================
-- Word Wrap Toggle
-- =========================
keymap("n", "<leader>w", function()
	vim.wo.wrap = not vim.wo.wrap
	print("Wrap: " .. tostring(vim.wo.wrap))
end, { desc = "Toggle word wrap" })

-- =========================
-- Terminal Keymaps
-- =========================

-- Terminal mode: exit with <Esc>
keymap("t", "<Esc>", [[<C-\><C-n>]], opts)
-- Terminal mode: window navigation
keymap("t", "<C-w>h", [[<C-\><C-n><C-w>h]], opts)
keymap("t", "<C-w>j", [[<C-\><C-n><C-w>j]], opts)
keymap("t", "<C-w>k", [[<C-\><C-n><C-w>k]], opts)
keymap("t", "<C-w>l", [[<C-\><C-n><C-w>l]], opts)
-- Terminal mode: close with <C-d>
keymap("t", "<C-d>", [[<C-\><C-n>:q<CR>]], opts)

-- Open terminal (normal mode)
keymap("n", "<leader>tt", function()
	vim.cmd("terminal")
end, vim.tbl_extend("force", opts, { desc = "Open terminal" }))
keymap("n", "<leader>tx", function()
	vim.cmd("split | terminal")
end, vim.tbl_extend("force", opts, { desc = "Open terminal in horizontal split" }))
keymap("n", "<leader>tv", function()
	vim.cmd("vsplit | terminal")
end, vim.tbl_extend("force", opts, { desc = "Open terminal in vertical split" }))
