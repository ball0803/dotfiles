-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
vim.g.mapleader = " "

local keymap = vim.keymap
keymap.del("n", "H")
keymap.del("n", "L")
keymap.set("n", "N", ":BufferLineCycleNext<CR>", { noremap = true, silent = true })
keymap.set("n", "S", ":BufferLineCyclePrev<CR>", { noremap = true, silent = true })

keymap.del({ "n", "x", "i", "s" }, "<C-s>")
keymap.set('n', '<leader>s', '<cmd>w<CR>')

keymap.set("n", "h", "j")
keymap.set("n", "t", "k")
keymap.set("n", "n", "h")
keymap.set("n", "s", "l")

keymap.set("v", "h", "j")
keymap.set("v", "t", "k")
keymap.set("v", "n", "h")
keymap.set("v", "s", "l")

keymap.set('i', '<C-h>', '<Down>')
keymap.set('i', '<C-t>', '<Up>')
keymap.set('i', '<C-n>', '<Left>')
keymap.set('i', '<C-s>', '<Right>')

keymap.set("n", "<C-I>", "<C-I>")
keymap.set("n", "<Tab>", "<Nop>")

keymap.del('n', '<C-h>')
keymap.del('n', '<C-j>')
keymap.del('n', '<C-k>')
keymap.del('n', '<C-l>')

keymap.set('n', '<C-h>', '<C-w>j')
keymap.set('n', '<C-t>', '<C-w>k')
keymap.set('n', '<C-n>', '<C-w>h')
keymap.set('n', '<C-s>', '<C-w>l')

-- increment/decrement numbers
keymap.set("n", "<leader>+", "<C-a>", { desc = "Increment number" }) -- increment
keymap.set("n", "<leader>-", "<C-x>", { desc = "Decrement number" }) -- decrement

keymap.set("i", "ht", "<ESC>", { desc = "Exit insert mode with jk" })

-- halfpage vertical movement center
keymap.set("n", "<C-d>", "<C-d>zz")
keymap.set("n", "<C-u>", "<C-u>zz")

keymap.set("n", "<A-H>", "yyp")
keymap.set("n", "<A-T>", "yyP")

keymap.set("n", "U", "<cmd>UndotreeToggle<CR>")
