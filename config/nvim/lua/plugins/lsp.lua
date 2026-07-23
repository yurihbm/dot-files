require("lazydev").setup()

vim.lsp.config("tsgo", {
	name = "typescript",
	settings = {
		typescript = {
			preferences = { importModuleSpecifierPreference = "non-relative" },
		},
	},
	cmd = function(dispatchers, config)
		local cmd = "tsc"
		if (config or {}).root_dir then
			local local_cmd = vim.fs.joinpath(config.root_dir, "node_modules/.bin", cmd)
			if vim.fn.executable(local_cmd) == 1 then
				cmd = local_cmd
			end
		end
		return vim.lsp.rpc.start({ "tsc", "--lsp", "--stdio" }, dispatchers)
	end,
})

vim.lsp.config("jsonls", {
	settings = {
		json = {
			schemas = require("schemastore").json.schemas(),
			validate = { enable = true },
		},
	},
})

vim.lsp.config("tailwindcss", {
	settings = {
		tailwindCSS = {
			classFunctions = { "tw", "twMerge", "tv", "clsx" },
		},
	},
})

vim.lsp.config("yamlls", {
	settings = {
		yaml = {
			schemas = require("schemastore").yaml.schemas(),
			redhat = { telemetry = { enabled = false } },
		},
	},
})

vim.lsp.enable({
	"golangci_lint_ls",
	"gopls",
	"jsonls",
	"lua_ls",
	"oxlint",
	"prismals",
	"pyright",
	"ruff",
	"sqruff",
	"tailwindcss",
	"tsgo",
	"yamlls",
})
