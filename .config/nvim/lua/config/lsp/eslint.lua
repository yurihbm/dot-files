-- =========================
-- Eslint LSP Configuration
-- =========================

-- This file provides a configuration for ESLint Language Server.

return {
	on_attach = function(_, bufnr)
		local augroup = vim.api.nvim_create_augroup
		local autocmd = vim.api.nvim_create_autocmd
		-- Run linting after formatting (with formatter.nvim).
		autocmd("User", {
			group = augroup("ESLintLSP", { clear = true }),
			pattern = "FormatterPost",
			callback = function()
				local ft = vim.bo.filetype
				if
					vim.tbl_contains({
						"javascript",
						"javascriptreact",
						"typescript",
						"typescriptreact",
					}, ft)
				then
					vim.lsp.buf.format({
						bufnr = bufnr,
						filter = function(client)
							return client.name == "eslint"
						end,
					})
				end
			end,
		})
	end,
}
