-- lua/plugins/telescope.lua

-- TELESCOPE: Fuzzy Finder
return {
	"nvim-telescope/telescope.nvim",
	tag = "0.1.8",
	dependencies = { "nvim-lua/plenary.nvim" },
	config = function()
		local builtin = require("telescope.builtin")
		-- KEYMAPS
		-- Find Files
		vim.keymap.set("n", "<leader>ff", builtin.find_files, {})
		-- Find Grep (Text)
		vim.keymap.set("n", "<leader>fg", builtin.live_grep, {})
		-- Find Buffers
		vim.keymap.set("n", "<leader>fb", builtin.buffers, {})
		-- Find Help
		vim.keymap.set("n", "<leader>fh", builtin.help_tags, {})
	end,
}
