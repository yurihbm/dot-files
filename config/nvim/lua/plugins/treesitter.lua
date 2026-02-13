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
