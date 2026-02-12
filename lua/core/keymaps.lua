-- lua/core/keymaps.lua

-- KEYBINDINGS
-- leader key, `:help mapleader`
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- syntax: mode, keys, command
vim.keymap.set("n", "<leader>w", "<cmd>write<cr>")
