-- lua/plugins/lsp.lua

return {
	"neovim/nvim-lspconfig",
	dependencies = {
		"williamboman/mason.nvim",
		-- "williamboman/mason-lspconfig.nvim",
	},
	config = function()
		require("mason").setup()
		local lspconfig = require("lspconfig")

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

