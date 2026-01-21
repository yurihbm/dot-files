local gh = function(x)
	return "https://github.com/" .. x
end

vim.pack.add({
	gh("nyoom-engineering/oxocarbon.nvim"),
	gh("folke/lazydev.nvim"),
	gh("b0o/schemastore.nvim"),
	gh("neovim/nvim-lspconfig"),
	gh("nvim-treesitter/nvim-treesitter"),
	gh("stevearc/conform.nvim"),
	gh("windwp/nvim-autopairs"),
	gh("windwp/nvim-ts-autotag"),
	gh("nvim-mini/mini.icons"),
	gh("nvim-mini/mini.statusline"),
	gh("nvim-mini/mini.indentscope"),
	gh("folke/snacks.nvim"),
	gh("zbirenbaum/copilot.lua"),
	gh("fang2hou/blink-copilot"),
	{ src = gh("saghen/blink.cmp"), version = vim.version.range("1.*") },
	gh("folke/which-key.nvim"),
})

require("plugins.oxocarbon")
require("plugins.lsp")
require("plugins.treesitter")
require("plugins.conform")
require("plugins.autopairs")
require("plugins.autotag")
require("plugins.icons")
require("plugins.statusline")
require("plugins.indentscope")
require("plugins.snacks")
require("plugins.blink")
require("plugins.copilot")
require("plugins.which_key")
