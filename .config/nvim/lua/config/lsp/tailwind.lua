-- =========================
-- Tailwind LSP Configuration
-- =========================

-- This file provides a configuration for Tailwind CSS Language Server.

return {
	settings = {
		tailwindCSS = {
			classFunctions = { "tw", "twMerge", "tv", "clsx" },
		},
	},
}
