-- =========================
-- Commands
-- =========================

-- This file provides a collection of user commands for various tasks.

-- =========================
-- Terminal Commands
-- =========================

-- User commands for terminal
vim.api.nvim_create_user_command("Term", function()
	vim.cmd("terminal")
end, { desc = "Open Terminal (Fullscreen)" })
vim.api.nvim_create_user_command("HTerm", function()
	vim.cmd("split | terminal")
end, { desc = "Open Terminal (Horizontal Split)" })
vim.api.nvim_create_user_command("VTerm", function()
	vim.cmd("vsplit | terminal")
end, { desc = "Open terminal (Vertical Split)" })
