-- lua/plugins/treesitter.lua

-- TREESITTER
return {
	"nvim-treesitter/nvim-treesitter",
	build = ":TSUpdate",
	branch = "master",
	config = function()
		require("nvim-treesitter.configs").setup({
			-- A list of parser languages, or "all"
			ensure_installed = { "lua", "vim", "vimdoc", "c" },
			-- Enable highlighting
			highlight = { enable = true },
			-- Enable indentation
			indent = { enable = true },
		})
	end,
}
