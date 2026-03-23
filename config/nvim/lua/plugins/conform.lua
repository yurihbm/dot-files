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
