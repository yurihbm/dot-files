return {
	{
		"williamboman/mason.nvim",
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
		config = function()
			vim.lsp.config("eslint", {
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
					vim.api.nvim_create_autocmd("BufWritePre", {
						group = vim.api.nvim_create_augroup("eslint_format", { clear = true }),
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
			})
		end,
	},
	{
		"pmizio/typescript-tools.nvim",
		dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
		opts = {
			settings = {
				publish_diagnostic_on = "change",
				tsserver_plugins = {
					"@styled/typescript-styled-plugin",
				},
			},
		},
	},
}
