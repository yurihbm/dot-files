-- =========================
-- Formatter Plugin
-- =========================

-- This file provides a plugin for code formatting.

return {
	"mhartington/formatter.nvim",
	-- NOTE: If you change the filetypes in 'ft', also update the autocmd pattern
	-- in the formatter setup below.
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
	config = function()
		local defaults = require("formatter.defaults")
		local prettierd = defaults.prettierd
		local gofmt = require("formatter.filetypes.go").gofmt
		local stylua = require("formatter.filetypes.lua").stylua
		local ruff = require("formatter.filetypes.python").ruff
		local shfmt = require("formatter.filetypes.sh").shfmt

		require("formatter").setup({
			logging = true,
			log_level = vim.log.levels.WARN,
			filetype = {
				css = { prettierd },
				go = { gofmt },
				javascript = { prettierd },
				javascriptreact = { prettierd },
				json = { prettierd },
				jsonc = { prettierd },
				lua = { stylua },
				markdown = { prettierd },
				python = { ruff },
				sh = { shfmt },
				typescript = { prettierd },
				typescriptreact = { prettierd },
				yaml = { prettierd },
			},
		})

		local augroup = vim.api.nvim_create_augroup
		local autocmd = vim.api.nvim_create_autocmd
		autocmd("BufWritePost", {
			group = augroup("Formatting", { clear = true }),
			pattern = {
				"*.css",
				"*.go",
				"*.js",
				"*.jsx",
				"*.json",
				"*.lua",
				"*.md",
				"*.py",
				"*.sh",
				"*.ts",
				"*.tsx",
				"*.yaml",
				"*.yml",
			},
			command = ":FormatWrite",
		})
	end,
	dependencies = {
		"williamboman/mason.nvim",
	},
}
