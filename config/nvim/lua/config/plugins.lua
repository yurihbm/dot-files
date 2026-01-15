local gh = function(x)
	return "https://github.com/" .. x
end

vim.pack.add({
	gh("folke/lazydev.nvim"),
	gh("nyoom-engineering/oxocarbon.nvim"),
	gh("neovim/nvim-lspconfig"),
	gh("nvim-treesitter/nvim-treesitter"),
	gh("b0o/schemastore.nvim"),
	gh("stevearc/conform.nvim"),
	gh("windwp/nvim-autopairs"),
	gh("windwp/nvim-ts-autotag"),
	gh("zbirenbaum/copilot.lua"),
	gh("nvim-mini/mini.clue"),
	gh("nvim-mini/mini.cursorword"),
	gh("nvim-mini/mini.icons"),
	gh("nvim-mini/mini-git"),
	gh("nvim-mini/mini.statusline"),
	gh("nvim-mini/mini.completion"),
	gh("nvim-mini/mini.cmdline"),
	gh("nvim-mini/mini.files"),
	gh("nvim-mini/mini.pick"),
	gh("nvim-mini/mini.indentscope"),
	gh("nvim-mini/mini.notify"),
	gh("nvim-mini/mini.extra"),
})

require("plugins.lsp")
require("plugins.oxocarbon")
require("plugins.treesitter")
require("plugins.conform")
require("plugins.autopairs")
require("plugins.autotag")
require("plugins.copilot")
require("plugins.clue")
require("plugins.cursorword")
require("plugins.icons")
require("plugins.git")
require("plugins.statusline")
require("plugins.completion")
require("plugins.cmdline")
require("plugins.files")
require("plugins.pick")
require("plugins.indentscope")
require("plugins.notify")
require("plugins.extra")
