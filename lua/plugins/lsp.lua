-- lua/plugins/lsp.lua

return {
	"neovim/nvim-lspconfig",
	dependencies = {
		"williamboman/mason.nvim",
		-- "williamboman/mason-lspconfig.nvim",
		"hrsh7th/cmp-nvim-lsp",
	},
	config = function()
		require("mason").setup()
		-- lspconfig.lua_ls.setup()
		-- local capabilities = require("cmp_nvim_lsp").default_capabilities()
		local capabilities = vim.lsp.protocol.make_client_capabilities() or {}
		local status_ok, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")

		if status_ok then
			local cmp_caps = cmp_nvim_lsp.default_capabilities()
			if cmp_caps then
				capabilities = vim.tbl_deep_extend("force", capabilities, cmp_caps)
			end
		end

		local lspconfig = require("lspconfig")
		local servers = {
			"clangd",
			"gopls",
			"pyright",
			"intelephense",
			"omnisharp",
			"jdtls",
		}

		for _, server in ipairs(servers) do
			lspconfig[server].setup({
				capabilities = capabilities,
			})
		end

		lspconfig.lua_ls.setup({
			capabilities = capabilities,
			settings = {
				Lua = {
					diagnostics = { globals = { "vim" } },
				},
			},
		})
	end,
}
