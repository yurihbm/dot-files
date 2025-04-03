-- Rename using LSP in normal mode
vim.api.nvim_set_keymap("n", "<leader>rn", "<cmd>lua vim.lsp.buf.rename()<CR>", { noremap = true, silent = true })
-- Rename using LSP in insert mode
vim.api.nvim_set_keymap("i", "<C-r>", "<cmd>lua vim.lsp.buf.rename()<CR>", { noremap = true, silent = true })

-- Go to definition using LSP in normal mode
vim.api.nvim_set_keymap("n", "<leader>gd", "<cmd>lua vim.lsp.buf.definition()<CR>", { noremap = true, silent = true })
-- Go to definition using LSP in insert mode
vim.api.nvim_set_keymap("i", "<C-g>", "<cmd>lua vim.lsp.buf.definition()<CR>", { noremap = true, silent = true })
-- Go to definition in a horizontal split using LSP in normal mode
vim.api.nvim_set_keymap(
	"n",
	"<leader>gx",
	"<cmd>split | lua vim.lsp.buf.definition()<CR>",
	{ noremap = true, silent = true }
)
-- Go to definition in a vertical split using LSP in normal mode
vim.api.nvim_set_keymap(
	"n",
	"<leader>gv",
	"<cmd>vsplit | lua vim.lsp.buf.definition()<CR>",
	{ noremap = true, silent = true }
)

-- Hover information using LSP in normal mode
vim.api.nvim_set_keymap("n", "<leader>h", "<cmd>lua vim.lsp.buf.hover()<CR>", { noremap = true, silent = true })

-- Diagnostic information using LSP in normal mode
vim.api.nvim_set_keymap("n", "<leader>d", "<cmd>lua vim.diagnostic.open_float()<CR>", { noremap = true, silent = true })

-- Show code actions using LSP in normal mode
vim.api.nvim_set_keymap("n", "<leader>ca", "<cmd>lua vim.lsp.buf.code_action()<CR>", { noremap = true, silent = true })
-- Show code actions using LSP in insert mode
vim.api.nvim_set_keymap("i", "<C-a>", "<cmd>lua vim.lsp.buf.code_action()<CR>", { noremap = true, silent = true })

-- Insert mode mappings
vim.api.nvim_set_keymap("i", "<C-h>", "<Left>", {})
vim.api.nvim_set_keymap("i", "<C-j>", "<Down>", {})
vim.api.nvim_set_keymap("i", "<C-k>", "<Up>", {})
vim.api.nvim_set_keymap("i", "<C-l>", "<Right>", {})

-- Command mode mappings
vim.api.nvim_set_keymap("c", "<C-h>", "<Left>", {})
vim.api.nvim_set_keymap("c", "<C-j>", "<Down>", {})
vim.api.nvim_set_keymap("c", "<C-k>", "<Up>", {})
vim.api.nvim_set_keymap("c", "<C-l>", "<Right>", {})
