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
	}
})


-- COLORSCHEME
vim.cmd.colorscheme "tokyonight"
