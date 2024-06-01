-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
vim.g.mapleader = " "
vim.g.maplocalleader = ","
local keymap = vim.keymap -- for conciseness

-- increment/decrement numbers
keymap.set("n", "<leader>+", "<C-a>", { desc = "Increment number" }) -- increment
keymap.set("n", "<leader>-", "<C-x>", { desc = "Decrement number" }) -- decrement
keymap.set("i", "jk", "<ESC>", { desc = "Exit insert mode with jk" })

-- halfpage vertical movement center
keymap.set("n", "<C-d>", "<C-d>zz")
keymap.set("n", "<C-u>", "<C-u>zz")

keymap.set("n", "ss", "<cmd>split<Return>")
keymap.set("n", "sv", "<cmd>vsplit<Return>")

keymap.set("n", "<A-J>", "yyp")
keymap.set("n", "<A-K>", "yyP")

keymap.set("n", "U", "<cmd>UndotreeToggle<CR>")
