-- =========================
-- JSON LSP Configuration
-- =========================

-- This file provides a configuration for the JSON Language Server..

return {
	settings = {
		json = {
			schemas = require("schemastore").json.schemas(),
			validate = { enable = true },
		},
	},
}
