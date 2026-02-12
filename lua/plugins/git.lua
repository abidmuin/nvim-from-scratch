-- lua/plugins/git.lua

return {
	-- 1. Vim-Fugitive (The Power Wrapper)
	"tpope/vim-fugitive",
}, {
	-- 2. Gitsigns (The Visual Helper)
	"lewis6991/gitsigns.nvim",
	config = function()
		require("gitsigns").setup({
			signs = {
				add = { text = "+" },
				change = { text = "~" },
				delete = { text = "_" },
				topdelete = { text = "‾" },
				changedelete = { text = "~" },
			},
		})
	end,
}
