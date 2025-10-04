-- =========================
-- Formatter Plugin
-- =========================

-- This file provides a plugin for code formatting.

return {
	"stevearc/conform.nvim",
	ft = {
		"css",
		"go",
		"javascript",
		"javascriptreact",
		"json",
		"jsonc",
		"lua",
		"markdown",
		"python",
		"sh",
		"typescript",
		"typescriptreact",
		"yaml",
	},
	opts = {
		formatters_by_ft = {
			css = { "prettierd" },
			go = { "gofmt" },
			javascript = { "prettierd" },
			javascriptreact = { "prettierd" },
			json = { "prettierd" },
			jsonc = { "prettierd" },
			lua = { "stylua" },
			markdown = { "prettierd" },
			python = { "ruff" },
			sh = { "shfmt" },
			typescript = { "prettierd" },
			typescriptreact = { "prettierd" },
			yaml = { "prettierd" },
		},
	},
	config = function(_, opts)
		local autocmd = vim.api.nvim_create_autocmd
		autocmd("BufWritePre", {
			pattern = "*",
			callback = function(args)
				require("conform").format({ bufnr = args.buf })
			end,
		})
		require("conform").setup(opts)
	end,
	dependencies = {
		"williamboman/mason.nvim",
	},
}
