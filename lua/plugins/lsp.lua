-- lua/plugins/lsp.lua

return
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			"williamboman/mason.nvim",
			-- "williamboman/mason-lspconfig.nvim",
		},
		config = function()
			-- 1. Setup Mason (The installer)
			require("mason").setup()

			-- CRITICAL CHANGE: We are SKIPPING mason-lspconfig.setup()
			-- because it is currently crashing your Neovim.

			-- 2. Setup the Servers Manually
			local lspconfig = require("lspconfig")

			-- Setup Lua Server
			lspconfig.lua_ls.setup({
				capabilities = capabilities,
				cmd = { "/home/abidmuin/.local/share/nvim/mason/bin/lua-language-server" },
				settings = {
					Lua = {
						diagnostics = { globals = { "vim" } },
					},
				},
			})

			-- Setup C Server
			-- lspconfig.clangd.setup({})
		end,
}