-- =========================
-- LSP (Language Server Protocol) Plugins
-- =========================

-- This file provides a collection of plugins for Language Server Protocol
-- support.

-- Define these filetypes based on mason-lspconfig's ensure_installed options.
local lsp_filetypes = {
	"dockerfile",
	"go",
	"javascript",
	"javascriptreact",
	"json",
	"jsonc",
	"lua",
	"prisma",
	"python",
	"typescript",
	"typescriptreact",
	"yaml",
}

return {
	{
		"williamboman/mason.nvim",
		cmd = "Mason",
		opts = {
			ui = {
				backdrop = 100,
				border = vim.g.border_style,
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
				"dockerls",
				"eslint",
				"golangci_lint_ls",
				"gopls",
				"jsonls",
				"lua_ls",
				"prismals",
				"pyright",
				"tailwindcss",
				"ts_ls",
				"yamlls",
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
			vim.lsp.config("jsonls", require("config.lsp.json"))
			vim.lsp.config("tailwindcss", require("config.lsp.tailwind"))
			vim.lsp.config("yamlls", require("config.lsp.yaml"))
		end,
		dependencies = {
			"b0o/schemastore.nvim",
		},
	},
	{
		"pmizio/typescript-tools.nvim",
		ft = { "typescript", "typescriptreact", "javascript", "javascriptreact" },
		opts = require("config.lsp.tsserver"),
		dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
	},
}
