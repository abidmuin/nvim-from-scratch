-- lua/lazy_setup.lua

-- lazy.nvim install directory
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

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
	spec = {
		{ import = "plugins.theme" },
		{ import = "plugins.lsp" },
		{ import = "plugins.treesitter" },
		{ import = "plugins.telescope" },

		-- FORMATTING
		{
			"stevearc/conform.nvim",
			event = { "BufReadPre", "BufNewFile" }, -- Load when opening a file
			config = function()
				local conform = require("conform")

				require("conform").setup({
					formatters_by_ft = {
						lua = { "stylua" }, -- Use 'stylua' for Lua
						c = { "clang-format" }, -- Use 'clang-format' for C
					},
					-- Enable "Format on Save"
					format_on_save = {
						lsp_fallback = true, -- If no formatter is found, ask the LSP to do it
						async = false, -- Wait for formatting to finish before saving
						timeout_ms = 500, -- Give up if it takes too long
					},
				})

				-- MANUAL TRIGGER: <Space>mp to "Make Pretty"
				vim.keymap.set({ "n", "v" }, "<leader>mp", function()
					conform.format({
						lsp_fallback = true,
						async = false,
						timeout_ms = 500,
					})
				end, { desc = "Format file or range (in visual mode)" })
			end,
		},
	},
})
