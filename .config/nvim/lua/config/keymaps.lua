-- Define default options for keymaps
local default_opts = { noremap = true, silent = true }

-- LSP-related keymaps.
vim.keymap.set(
	"n",
	"<leader>rn",
	vim.lsp.buf.rename,
	vim.tbl_extend("force", default_opts, {
		desc = "Rename",
	})
)
vim.keymap.set(
	"i",
	"<C-r>",
	vim.lsp.buf.rename,
	vim.tbl_extend("force", default_opts, {
		desc = "Rename (insert mode)",
	})
)
vim.keymap.set(
	"n",
	"<leader>gd",
	vim.lsp.buf.definition,
	vim.tbl_extend("force", default_opts, {
		desc = "Go to definition",
	})
)
vim.keymap.set(
	"i",
	"<C-g>",
	vim.lsp.buf.definition,
	vim.tbl_extend("force", default_opts, {
		desc = "Go to definition (insert mode)",
	})
)
vim.keymap.set(
	"n",
	"<leader>gx",
	function()
		vim.cmd("split")
		vim.lsp.buf.definition()
	end,
	vim.tbl_extend("force", default_opts, {
		desc = "Go to definition (horizontal split)",
	})
)
vim.keymap.set(
	"n",
	"<leader>gv",
	function()
		vim.cmd("vsplit")
		vim.lsp.buf.definition()
	end,
	vim.tbl_extend("force", default_opts, {
		desc = "Go to definition (vertical split)",
	})
)
vim.keymap.set(
	"n",
	"<leader>h",
	vim.lsp.buf.hover,
	vim.tbl_extend("force", default_opts, {
		desc = "Hover information",
	})
)
vim.keymap.set(
	"n",
	"<leader>d",
	vim.diagnostic.open_float,
	vim.tbl_extend("force", default_opts, {
		desc = "Diagnostic information",
	})
)
vim.keymap.set(
	"n",
	"<leader>ca",
	vim.lsp.buf.code_action,
	vim.tbl_extend("force", default_opts, {
		desc = "Code actions",
	})
)
vim.keymap.set(
	"i",
	"<C-a>",
	vim.lsp.buf.code_action,
	vim.tbl_extend("force", default_opts, {
		desc = "Code actions (insert mode)",
	})
)

-- Disable default hover keymap.
vim.keymap.set("n", "K", "<Nop>", { noremap = true, silent = true })

-- Insert mode movement keymaps.
vim.keymap.set("i", "<C-h>", "<Left>", { desc = "Move left" })
vim.keymap.set("i", "<C-j>", "<Down>", { desc = "Move down" })
vim.keymap.set("i", "<C-k>", "<Up>", { desc = "Move up" })
vim.keymap.set("i", "<C-l>", "<Right>", { desc = "Move right" })

-- Command mode movement keymaps.
vim.keymap.set("c", "<C-h>", "<Left>", { desc = "Move left (command mode)" })
vim.keymap.set("c", "<C-j>", "<Down>", { desc = "Move down (command mode)" })
vim.keymap.set("c", "<C-k>", "<Up>", { desc = "Move up (command mode)" })
vim.keymap.set("c", "<C-l>", "<Right>", { desc = "Move right (command mode)" })

-- Split resizing keymaps.
vim.keymap.set("n", "<C-Up>", function()
	vim.cmd("resize " .. (vim.fn.winheight(0) - 2))
end, vim.tbl_extend("force", default_opts, { desc = "Resize split up" }))

vim.keymap.set("n", "<C-Down>", function()
	vim.cmd("resize " .. (vim.fn.winheight(0) + 2))
end, vim.tbl_extend("force", default_opts, { desc = "Resize split down" }))

vim.keymap.set("n", "<C-Left>", function()
	vim.cmd("vertical resize " .. (vim.fn.winwidth(0) - 2))
end, vim.tbl_extend("force", default_opts, { desc = "Resize split left" }))

vim.keymap.set("n", "<C-Right>", function()
	vim.cmd("vertical resize " .. (vim.fn.winwidth(0) + 2))
end, vim.tbl_extend("force", default_opts, { desc = "Resize split right" }))

-- Copy and paste using system clipboard.
vim.keymap.set(
	"v",
	"<leader>y",
	'"+y',
	vim.tbl_extend("force", default_opts, {
		desc = "Copy to clipboard",
	})
)
vim.keymap.set(
	"n",
	"<leader>p",
	'"+p',
	vim.tbl_extend("force", default_opts, {
		desc = "Paste from clipboard",
	})
)

-- Toggle word wrap.
vim.keymap.set("n", "<leader>w", function()
	vim.wo.wrap = not vim.wo.wrap
	print("Wrap: " .. tostring(vim.wo.wrap))
end, {
	desc = "Toggle word wrap",
})
