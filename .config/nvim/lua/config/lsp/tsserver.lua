-- =========================
-- TS Server Configuration
-- =========================

-- This file provides a configuration for the TypeScript Language Server.

return {
	on_attach = function(_, bufnr)
		local group = vim.api.nvim_create_augroup("tstools_unused_imports", { clear = true })
		vim.api.nvim_create_autocmd("BufWritePre", {
			group = group,
			buffer = bufnr,
			callback = function()
				vim.cmd("TSToolsRemoveUnusedImports sync")
			end,
		})
	end,
	settings = {
		expose_as_code_action = "all",
		tsserver_plugins = {
			"@styled/typescript-styled-plugin",
		},
	},
}
