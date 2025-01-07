return {
	{
		"williamboman/mason.nvim",
		opts = {
			ui = {
				icons = {
					---@since 1.0.0
					-- The list icon to use for installed packages.
					package_installed = "",
					---@since 1.0.0
					-- The list icon to use for packages that are installing, or queued for installation.
					package_pending = "󰦗",
					---@since 1.0.0
					-- The list icon to use for packages that are not installed.
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
					-- ts_ls (typescript-language-server) setup is handled by the typescript-tools plugin
					if server_name == "ts_ls" then
						return
					end
					lspconfig[server_name].setup({})
				end,
				["eslint"] = function()
					lspconfig.eslint.setup({
						on_attach = function(_, bufnr)
							vim.api.nvim_create_autocmd("BufWritePre", {
								buffer = bufnr,
								command = "EslintFixAll",
							})
						end,
					})
				end,
				["lua_ls"] = function()
					lspconfig.lua_ls.setup({
						settings = {
							Lua = {
								diagnostics = {
									-- Get the language server to recognize the `vim` global
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
	{
		"antosha417/nvim-lsp-file-operations",
		dependencies = {
			"nvim-lua/plenary.nvim",
		},
		config = function()
			require("lsp-file-operations").setup()
		end,
	},
}
