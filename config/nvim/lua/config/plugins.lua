local gh = function(x)
	return "https://github.com/" .. x
end
local autocmd = vim.api.nvim_create_autocmd
local keymap = vim.keymap.set

vim.pack.add({
	gh("nyoom-engineering/oxocarbon.nvim"),
	gh("neovim/nvim-lspconfig"),
	gh("nvim-treesitter/nvim-treesitter"),
	gh("b0o/schemastore.nvim"),
	gh("stevearc/conform.nvim"),
	gh("karb94/neoscroll.nvim"),
	gh("folke/which-key.nvim"),
	gh("windwp/nvim-autopairs"),
	gh("nvim-mini/mini.cursorword"),
	gh("nvim-mini/mini.icons"),
	gh("nvim-mini/mini-git"),
	gh("nvim-mini/mini.statusline"),
	gh("nvim-mini/mini.completion"),
	gh("nvim-mini/mini.cmdline"),
	gh("nvim-mini/mini.files"),
	gh("zbirenbaum/copilot.lua"),
})

vim.opt.background = "dark"
vim.cmd.colorscheme("oxocarbon")
vim.api.nvim_set_hl(0, "Pmenu", { bg = "#161616", fg = "#d0d0d0" })
vim.api.nvim_set_hl(0, "FloatBorder", { bg = "#161616", fg = "#d0d0d0" })
vim.api.nvim_set_hl(0, "NormalFloat", { bg = "#161616", fg = "#d0d0d0" })
-- Fix visibility for NonText characters.
vim.api.nvim_set_hl(0, "NonText", { fg = "#525252" })

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

require("nvim-treesitter").install({
	"c",
	"lua",
	"vim",
	"vimdoc",
	"go",
	"typescript",
	"tsx",
	"javascript",
	"html",
	"css",
	"styled",
	"regex",
	"bash",
	"yaml",
	"toml",
	"prisma",
	"markdown",
	"markdown_inline",
	"dockerfile",
})
vim.api.nvim_create_autocmd("FileType", {
	pattern = {
		"c",
		"lua",
		"go",
		"typescript",
		"typescriptreact",
		"javascript",
		"javascriptreact",
		"html",
		"css",
		"bash",
		"yaml",
		"toml",
		"prisma",
		"markdown",
		"dockerfile",
	},
	callback = function()
		vim.treesitter.start()
	end,
})

autocmd("BufWritePre", {
	pattern = "*",
	callback = function(args)
		require("conform").format({ bufnr = args.buf })
	end,
})
require("conform").setup({
	formatters_by_ft = {
		css = { "prettierd" },
		go = { "gofmt" },
		javascript = { "prettierd" },
		javascriptreact = { "prettierd" },
		json = { "prettierd" },
		jsonc = { "prettierd" },
		lua = { "stylua" },
		markdown = { "prettierd" },
		python = { "ruff" },
		sh = { "shfmt" },
		typescript = { "prettierd" },
		typescriptreact = { "prettierd" },
		yaml = { "prettierd" },
	},
})

require("neoscroll").setup()

require("which-key").setup({
	preset = "helix",
})

require("nvim-autopairs").setup()

require("mini.cursorword").setup()
require("mini.git").setup()
require("mini.icons").setup()
require("mini.statusline").setup()
vim.opt.laststatus = 3
require("mini.completion").setup()
vim.o.pumborder = "single"
require("mini.cmdline").setup()
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
require("mini.files").setup({
	windows = {
		preview = true,
		width_focus = 40,
		width_nofocus = 40,
		width_preview = 40,
	},
})
keymap("n", "e", function()
	MiniFiles.open()
end)

require("copilot").setup({
	suggestion = {
		hide_during_completion = false,
	},
	filetypes = {
		markdown = true,
	},
})
