local autocmd = vim.api.nvim_create_autocmd

vim.api.nvim_create_user_command("WriteNoFormat", function()
	vim.b.disable_autoformat_once = true
	vim.cmd.write()
end, { desc = "Write current buffer without formatting" })

autocmd("BufWritePre", {
	pattern = "*",
	callback = function(args)
		if vim.b[args.buf].disable_autoformat_once then
			vim.b[args.buf].disable_autoformat_once = false
			return
		end

		local oxfmt_filetypes = {
			"css",
			"javascript",
			"javascriptreact",
			"json",
			"jsonc",
			"markdown",
			"typescript",
			"typescriptreact",
			"yaml",
		}
		local filetype = vim.bo[args.buf].filetype

		if vim.tbl_contains(oxfmt_filetypes, filetype) then
			require("conform").format({ bufnr = args.buf, lsp_format = "prefer", name = "oxfmt" })
			return
		end

		require("conform").format({ bufnr = args.buf })
	end,
})

require("conform").setup({
	formatters_by_ft = {
		go = { "gofmt" },
		lua = { "stylua" },
		python = { "ruff" },
		sh = { "shfmt" },
	},
})
