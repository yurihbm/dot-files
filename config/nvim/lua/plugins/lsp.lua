require("lazydev").setup()

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
	"dockerls",
	"golangci_lint_ls",
	"gopls",
	"jsonls",
	"lua_ls",
	"prismals",
	"pyright",
	"tailwindcss",
	"ts_ls",
	"yamlls",
})
