require("lint").linters_by_ft = {
	go = { "golangcilint" },
	javascript = { "eslint" },
	javascriptreact = { "eslint" },
	typescript = { "eslint" },
	typescriptreact = { "eslint" },
	sql = { "sqruff" },
	python = { "ruff" },
}

local autocmd = vim.api.nvim_create_autocmd

autocmd("BufWritePost", {
	pattern = "*",
	callback = function()
		require("lint").try_lint()
	end,
})
