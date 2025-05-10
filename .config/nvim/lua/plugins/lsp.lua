-- =========================
-- LSP (Language Server Protocol) Plugins
-- =========================

-- This file provides a collection of plugins for Language Server Protocol
-- Protocol support.

-- Define these filetypes based on mason-lspconfig's ensure_installed options.
local lsp_filetypes = {
	"lua",
	"typescript",
	"typescriptreact",
	"javascript",
	"javascriptreact",
	"python",
	"go",
	"c",
}

return {
	{
		"williamboman/mason.nvim",
		cmd = "Mason",
		opts = {
			ui = {
				backdrop = 100,
				border = "single",
				icons = {
					package_installed = "",
					package_pending = "󰦗",
					package_uninstalled = "",
				},
			},
		},
	},
	{
		"williamboman/mason-lspconfig.nvim",
		ft = lsp_filetypes,
		opts = {
			ensure_installed = {
				"ts_ls",
				"eslint",
				"tailwindcss",
				"lua_ls",
				"gopls",
				"clangd",
				"pyright",
			},
			automatic_enable = {
				exclude = {
					-- ts_ls config is handled in typescript-tools.nvim
					"ts_ls",
				},
			},
		},
	},
	{
		"neovim/nvim-lspconfig",
		ft = lsp_filetypes,
		config = function()
			vim.lsp.config("eslint", require("config.lsp.eslint"))
		end,
	},
	{
		"pmizio/typescript-tools.nvim",
		ft = { "typescript", "typescriptreact", "javascript", "javascriptreact" },
		opts = require("config.lsp.tsserver"),
		dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
	},
}
