-- =========================
-- TS Server Configuration
-- =========================

-- This file provides a configuration for the TypeScript Language Server.

return {
	settings = {
		expose_as_code_action = "all",
		tsserver_plugins = {
			"@styled/typescript-styled-plugin",
		},
	},
}
