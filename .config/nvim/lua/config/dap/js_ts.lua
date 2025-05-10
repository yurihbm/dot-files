local dap = require("dap")

dap.adapters.firefox = {
	type = "executable",
	command = "node",
	args = {
		vim.fn.stdpath("data") .. "/mason/packages/firefox-debug-adapter/dist/adapter.bundle.js",
	},
}

local default_firefox_config = {
	name = "Debug with Firefox",
	type = "firefox",
	request = "launch",
	reAttach = true,
	url = "http://localhost:3000",
	webRoot = "${workspaceFolder}",
	firefoxExecutable = "/usr/bin/firefox",
}

dap.configurations.typescript = { default_firefox_config }
dap.configurations.javascript = { default_firefox_config }
dap.configurations.typescriptreact = { default_firefox_config }
dap.configurations.javascriptreact = { default_firefox_config }
