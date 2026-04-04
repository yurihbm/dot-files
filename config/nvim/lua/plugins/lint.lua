require("lint").linters_by_ft = {
	go = { "golangcilint" },
	javascript = { "eslint_d" },
	javascriptreact = { "eslint_d" },
	typescript = { "eslint_d" },
	typescriptreact = { "eslint_d" },
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
