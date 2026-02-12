-- lua/plugins/autocomplete.lua

return {
	"hrsh7th/nvim-cmp",
	dependencies = {
		"hrsh7th/cmp-nvim-lsp", -- Source for LSP
		"L3MON4D3/LuaSnip", -- Snippet Engine
		"saadparwaiz1/cmp_luasnip", -- Source for Snippets
	},
	config = function()
		local cmp = require("cmp")
		cmp.setup({
			-- 1. Snippet Engine (Required)
			snippet = {
				expand = function(args)
					require("luasnip").lsp_expand(args.body)
				end,
			},
			-- 2. Key Mappings
			mapping = cmp.mapping.preset.insert({
				["<C-Space>"] = cmp.mapping.complete(), -- Manually trigger menu
				["<CR>"] = cmp.mapping.confirm({ select = true }), -- Enter to select
			}),
			-- 3. Sources (Where words come from)
			sources = cmp.config.sources({
				{ name = "nvim_lsp" }, -- From the LSP (Smart code)
				{ name = "luasnip" }, -- Snippets
			}, {
				{ name = "buffer" }, -- Text in the current file
			}),
		})
	end,
}
