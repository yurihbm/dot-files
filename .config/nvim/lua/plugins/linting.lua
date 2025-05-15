-- =========================
-- Linting Plugin
-- =========================

-- This file provides a plugin for code linting.
-- Use for languages that does not provide a linting language server.

local linting_filetypes = {
	"markdown",
}

return {
	"mfussenegger/nvim-lint",
	ft = linting_filetypes,
	keys = {
		{
			"<leader>ll",
			function()
				require("lint").try_lint()
			end,
			desc = "Lint current buffer",
			silent = true,
		},
	},
	config = function()
		local lint = require("lint")
		lint.linters_by_ft = {
			markdown = { "markdownlint" },
		}

		local augroup = vim.api.nvim_create_augroup
		local autocmd = vim.api.nvim_create_autocmd
		-- Run linting after formatting (with formatter.nvim).
		autocmd("User", {
			group = augroup("Linting", { clear = true }),
			pattern = "FormatterPost",
			callback = function()
				local ft = vim.bo.filetype
				if vim.tbl_contains(linting_filetypes, ft) then
					lint.try_lint()
				end
			end,
		})
	end,
}
