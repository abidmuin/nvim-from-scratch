-- lua/lazy_setup.lua

-- lazy.nvim install directory
local lazypath = vim.fn.stdpath("data").."/lazy/lazy.nvim"

-- if lazy.nvim isn't installed
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable",
		lazypath,
	})
end

-- add it to the runtime path
vim.opt.rtp:prepend(lazypath)

-- start
require("lazy").setup({
	-- COLORSCHEMES
	"folke/tokyonight.nvim",
	-- TREESITTER
	{
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
		end
	},
	-- TELESCOPE: Fuzzy Finder
	{
		"nvim-telescope/telescope.nvim", tag='0.1.8',
		dependencies = {'nvim-lua/plenary.nvim'},
		config = function()
			local builtin = require('telescope.builtin')
			-- KEYMAPS
			-- Find Files
			vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
			-- Find Grep (Text)
			vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
			-- Find Buffers
			vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
			-- Find Help
			vim.keymap.set('n', '<leader>fh', builtin.help_tags, {}) 
end

	},
})


-- COLORSCHEME
vim.cmd.colorscheme "tokyonight"
