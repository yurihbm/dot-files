-- Use one statusline globally.
vim.opt.laststatus = 3
-- Hide mode information from cmdline.
vim.opt.showmode = false
-- Hide cmdline.
vim.opt.cmdheight = 0

return {
	{
		"windwp/nvim-autopairs",
		event = "InsertEnter",
		config = true,
	},
	{
		"windwp/nvim-ts-autotag",
		opts = {
			opts = {
				enable_close = true,
				enable_rename = true,
				enable_close_on_slash = false,
			},
		},
	},
	{
		"nvim-lualine/lualine.nvim",
		dependencies = {
			"echasnovski/mini.icons",
		},
		config = function()
			-- Mock nvim-web-devicons to use mini.icons instead.
			require("mini.icons").mock_nvim_web_devicons()

			require("lualine").setup({
				options = {
					global_status = true,
					disabled_filetypes = { "snacks_*" },
				},
			})
		end,
	},
}
