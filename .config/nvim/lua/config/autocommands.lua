-- =========================
-- Autocommands
-- =========================

-- This file provides a collection of autocommands for various events.

-- =========================
-- General Autocommands
-- =========================

-- Change directory to the first argument if passed.
vim.api.nvim_create_autocmd("VimEnter", {
	callback = function()
		local args = vim.fn.argv()
		if type(args) == "string" then
			args = { args }
		end
		for _, arg in ipairs(args) do
			if vim.fn.isdirectory(arg) == 1 then
				vim.cmd.cd(arg)
				break
			end
		end
	end,
})

-- =========================
-- Terminal Autocommands
-- =========================

-- Automatically enter insert mode when terminal opens.
vim.api.nvim_create_autocmd("TermOpen", {
	pattern = "*",
	callback = function()
		vim.cmd("startinsert!")
	end,
})

-- Disable line numbers when opening a terminal buffer
vim.api.nvim_create_autocmd("TermOpen", {
	pattern = "*",
	callback = function()
		vim.opt_local.number = false -- Disable absolute line numbers
		vim.opt_local.relativenumber = false -- Disable relative line numbers
	end,
})
