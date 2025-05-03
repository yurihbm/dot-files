return {
	{
		"williamboman/mason.nvim",
		opts = {
			ui = {
				backdrop = 100,
				border = "rounded",
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
		config = function()
			local lspconfig = require("lspconfig")

			require("mason-lspconfig").setup({
				automatic_installation = false,
				ensure_installed = {
					"ts_ls",
					"eslint",
					"tailwindcss",
					"lua_ls",
					"gopls",
					"clangd",
					"pyright",
				},
			})

			require("mason-lspconfig").setup_handlers({
				function(server_name)
					-- ts_ls (typescript-language-server) setup is handled by the
					-- typescript-tools plugin.
					if server_name == "ts_ls" then
						return
					end
					lspconfig[server_name].setup({})
				end,
				["eslint"] = function()
					lspconfig.eslint.setup({
						on_attach = function(_, bufnr)
							-- Fix eslint problems on write.
							vim.api.nvim_create_autocmd("BufWritePre", {
								buffer = bufnr,
								command = "EslintFixAll",
							})
						end,
						settings = (function()
							local yarn_sdks_path = vim.fn.getcwd() .. "/.yarn/sdks"
							if vim.fn.isdirectory(yarn_sdks_path) == 1 then
								return { nodePath = yarn_sdks_path }
							else
								return {}
							end
						end)(),
					})
				end,
				["lua_ls"] = function()
					lspconfig.lua_ls.setup({
						settings = {
							Lua = {
								diagnostics = {
									globals = { "vim" },
								},
							},
						},
					})
				end,
			})
		end,
	},
	"neovim/nvim-lspconfig",
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
