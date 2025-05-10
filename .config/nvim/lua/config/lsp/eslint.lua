-- =========================
-- Eslint LSP Configuration
-- =========================

-- This file provides a configuration for ESLint Language Server.

return {
	settings = (function()
		local yarn_sdks_path = vim.fn.getcwd() .. "/.yarn/sdks"
		if vim.fn.isdirectory(yarn_sdks_path) == 1 then
			return {
				nodePath = yarn_sdks_path,
				codeActionOnSave = {
					enable = true,
					mode = "all",
				},
			}
		else
			return {
				codeActionOnSave = {
					enable = true,
					mode = "all",
				},
			}
		end
	end)(),
	on_attach = function(_, bufnr)
		local autocmd = vim.api.nvim_create_autocmd
		autocmd("BufWritePre", {
			buffer = bufnr,
			callback = function()
				vim.lsp.buf.format({
					bufnr = bufnr,
					filter = function(client)
						return client.name == "eslint"
					end,
				})
			end,
		})
	end,
}
