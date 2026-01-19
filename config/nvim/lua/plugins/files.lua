local keymap = vim.keymap.set

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
	if not MiniFiles.close() then
		local buf_name = vim.api.nvim_buf_get_name(0)
		local path = nil

		-- Check if the buffer has a name and if the file actually exists on disk
		if buf_name ~= "" and vim.fn.filereadable(buf_name) == 1 then
			path = buf_name
		end

		-- Open MiniFiles. If 'path' is nil, it defaults to the Current Working Directory
		MiniFiles.open(path)

		-- Always reveal the cwd to ensure orientation
		MiniFiles.reveal_cwd()
	end
end)

local map_split = function(buf_id, lhs, direction)
	local rhs = function()
		-- Create a new split in the specified direction
		local cur_target = MiniFiles.get_explorer_state().target_window
		local new_target = vim.api.nvim_win_call(cur_target, function()
			vim.cmd(direction .. " split")
			return vim.api.nvim_get_current_win()
		end)

		MiniFiles.set_target_window(new_target)
		-- Extra: open the file and close the explorer
		MiniFiles.go_in({ close_on_file = true })
	end

	local desc = "Split " .. direction
	keymap("n", lhs, rhs, { buffer = buf_id, desc = desc })
end

vim.api.nvim_create_autocmd("User", {
	pattern = "MiniFilesBufferCreate",
	callback = function(args)
		local buf_id = args.data.buf_id
		map_split(buf_id, "<C-s>", "belowright horizontal")
		map_split(buf_id, "<C-v>", "belowright vertical")

		keymap("n", "gy", function()
			local path = (MiniFiles.get_fs_entry() or {}).path
			if path then
				vim.fn.setreg("+", path)
				vim.notify("Path yanked: " .. path)
			end
		end, { buffer = buf_id, desc = "Yank path" })
	end,
})

vim.api.nvim_create_autocmd("User", {
	pattern = { "MiniFilesActionRename", "MiniFilesActionMove" },
	callback = function(event)
		Snacks.rename.on_rename_file(event.data.from, event.data.to)
	end,
})
