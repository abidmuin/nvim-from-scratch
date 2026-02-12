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
	-- COLORSCHEMES
	-- TOKYO NIGHT
	-- {
	-- 	"folke/tokyonight.nvim",
	-- 	lazy = false,
	-- 	priority = 1000,
	-- 	config = function()
	-- 		vim.cmd.colorscheme("tokyonight-night")
	-- 	end,
	-- },
	-- GRUVBOX NVIM
	{
		"ellisonleao/gruvbox.nvim",
		priority = 1000,
		config = function()
			require("gruvbox").setup({
				terminal_colors = true, -- add neovim terminal colors
				undercurl = true,
				underline = true,
				bold = true,
				italic = {
					strings = true,
					emphasis = true,
					comments = true,
					operators = false,
					folds = true,
				},
				strikethrough = true,
				invert_selection = false,
				invert_signs = false,
				invert_tabline = false,
				inverse = true, -- invert background for search, diffs, statuslines and errors
				contrast = "hard", -- can be "hard", "soft" or empty string
				palette_overrides = {},
				overrides = {},
				dim_inactive = false,
				transparent_mode = false,
			})
			vim.cmd.colorscheme("gruvbox")
		end,
	},
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
		end,
	},
	-- TELESCOPE: Fuzzy Finder
	{
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
	},
	-- LSP Support (Safe Mode)
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
	},
	-- AUTOCOMPLETION
	{
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
	},
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
	-- VCS: GIT
	{
		-- 1. Vim-Fugitive (The Power Wrapper)
		"tpope/vim-fugitive",
	},
	{
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
	},
})
