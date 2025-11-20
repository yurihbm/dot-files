-- =========================
-- Keymaps
-- =========================

-- This file provides a collection of keymaps for various modes.

local keymap = vim.keymap.set
local opts = { noremap = true, silent = true }

-- =========================
-- LSP Keymaps
-- =========================
keymap("n", "<leader>rn", vim.lsp.buf.rename, vim.tbl_extend("force", opts, { desc = "[R]e[n]ame" }))
keymap("i", "<C-r>", vim.lsp.buf.rename, vim.tbl_extend("force", opts, { desc = "Rename (Insert Mode)" }))
keymap("n", "<leader>gd", vim.lsp.buf.definition, vim.tbl_extend("force", opts, { desc = "[G]o to [D]efinition" }))
keymap("i", "<C-g>", vim.lsp.buf.definition, vim.tbl_extend("force", opts, { desc = "Go to Definition (Insert Mode)" }))
keymap("n", "<leader>gh", function()
	vim.cmd("split")
	vim.lsp.buf.definition()
end, vim.tbl_extend("force", opts, { desc = "[G]o to Definition ([H]orizontal Split)" }))
keymap("n", "<leader>gv", function()
	vim.cmd("vsplit")
	vim.lsp.buf.definition()
end, vim.tbl_extend("force", opts, { desc = "[G]o to Definition ([V]ertical Split)" }))
keymap("n", "<leader>h", vim.lsp.buf.hover, vim.tbl_extend("force", opts, { desc = "[H]over Information" }))
keymap(
	"n",
	"<leader>d",
	vim.diagnostic.open_float,
	vim.tbl_extend("force", opts, { desc = "[D]iagnostic Information" })
)
keymap("n", "<leader>ca", vim.lsp.buf.code_action, vim.tbl_extend("force", opts, { desc = "[C]ode [A]ctions" }))
keymap("i", "<C-a>", vim.lsp.buf.code_action, vim.tbl_extend("force", opts, { desc = "Code Actions (Insert Mode)" }))
-- Disable default hover keymap.
keymap("n", "K", "<Nop>", { noremap = true, silent = true })

-- =========================
-- Movement Keymaps (Insert/Command mode)
-- =========================
-- Insert mode
keymap("i", "<C-h>", "<Left>", { desc = "Move Left" })
keymap("i", "<C-j>", "<Down>", { desc = "Move Down" })
keymap("i", "<C-k>", "<Up>", { desc = "Move Up" })
keymap("i", "<C-l>", "<Right>", { desc = "Move Right" })
-- Command mode
keymap("c", "<C-h>", "<Left>", { desc = "Move Left (Command Mode)" })
keymap("c", "<C-j>", "<Down>", { desc = "Move Down (Command Mode)" })
keymap("c", "<C-k>", "<Up>", { desc = "Move Up (Command Mode)" })
keymap("c", "<C-l>", "<Right>", { desc = "Move Right (Command Mode)" })

-- =========================
-- Split Resizing Keymaps
-- =========================
keymap("n", "<C-Up>", function()
	vim.cmd("resize " .. (vim.fn.winheight(0) - 2))
end, vim.tbl_extend("force", opts, { desc = "Resize Split Up" }))
keymap("n", "<C-Down>", function()
	vim.cmd("resize " .. (vim.fn.winheight(0) + 2))
end, vim.tbl_extend("force", opts, { desc = "Resize Split Down" }))
keymap("n", "<C-Left>", function()
	vim.cmd("vertical resize " .. (vim.fn.winwidth(0) - 2))
end, vim.tbl_extend("force", opts, { desc = "Resize Split Left" }))
keymap("n", "<C-Right>", function()
	vim.cmd("vertical resize " .. (vim.fn.winwidth(0) + 2))
end, vim.tbl_extend("force", opts, { desc = "Resize Split Right" }))

-- =========================
-- Clipboard Keymaps
-- =========================
keymap("v", "<leader>y", '"+y', vim.tbl_extend("force", opts, { desc = "Cop[y] to System Clipboard" }))
keymap("n", "<leader>p", '"+p', vim.tbl_extend("force", opts, { desc = "[P]aste from System Clipboard" }))

-- =========================
-- Word Wrap Toggle
-- =========================
keymap("n", "<leader>w", function()
	vim.wo.wrap = not vim.wo.wrap
	print("Wrap: " .. tostring(vim.wo.wrap))
end, { desc = "Toggle word [w]rap" })

-- =========================
-- Terminal Keymaps
-- =========================

-- Terminal mode: exit with <C-q>
keymap("t", "<C-q>", [[<C-\><C-n>]], vim.tbl_extend("force", opts, { desc = "Exit Terminal Mode" }))
-- Terminal mode: close with <C-d>
keymap("t", "<C-d>", [[<C-\><C-n>:q<CR>]], vim.tbl_extend("force", opts, { desc = "Close Terminal" }))

-- Open terminal (normal mode)
keymap("n", "<leader>tf", function()
	vim.cmd("terminal")
end, vim.tbl_extend("force", opts, { desc = "Open [T]erminal ([F]ullscreen)" }))
keymap("n", "<leader>th", function()
	vim.cmd("split | terminal")
end, vim.tbl_extend("force", opts, { desc = "Open [T]erminal ([H]orizontal Split)" }))
keymap("n", "<leader>tv", function()
	vim.cmd("vsplit | terminal")
end, vim.tbl_extend("force", opts, { desc = "Open [T]erminal ([V]ertical Split)" }))
