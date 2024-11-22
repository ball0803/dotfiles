-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua

-- Set the leader key to space
vim.g.mapleader = " "

local keymap = vim.keymap

-- Remove default H and L mappings for buffer navigation
keymap.del("n", "H")
keymap.del("n", "L")

-- Buffer navigation: N and S for previous/next buffer in BufferLine
keymap.set("n", "N", ":BufferLineCyclePrev<CR>", { noremap = true, silent = true })
keymap.set("n", "S", ":BufferLineCycleNext<CR>", { noremap = true, silent = true })

-- Unmap Ctrl-s globally to avoid conflicts, set saving to <leader>s
keymap.del({ "n", "x", "i", "s" }, "<C-s>")
keymap.set("n", "<leader>s", "<cmd>w<CR>")

-- Search navigation: Alt-n and Alt-Shift-n to find next/previous occurrences
keymap.set("n", "<M-n>", "n", { noremap = true, silent = true })
keymap.set("n", "<M-N>", "N", { noremap = true, silent = true })

-- Dvorak navigation key replacements in normal and visual modes
local dvorak_nav_keys = { h = "j", t = "k", n = "h", s = "l" }
for key, action in pairs(dvorak_nav_keys) do
  keymap.set({ "n", "v" }, key, action) -- Normal and Visual modes: h/t/n/s for Down/Up/Left/Right
end

-- Arrow key replacements in insert mode for Dvorak layout
local insert_dvorak_nav_keys = {
  ["<C-h>"] = "<Down>", -- Ctrl-h for Down
  ["<C-t>"] = "<Up>", -- Ctrl-t for Up
  ["<C-n>"] = "<Left>", -- Ctrl-n for Left
  ["<C-s>"] = "<Right>", -- Ctrl-s for Right
}
for key, action in pairs(insert_dvorak_nav_keys) do
  keymap.set("i", key, action)
end

-- Retain default <C-I> mapping, disable <Tab> in normal mode
keymap.set("n", "<C-I>", "<C-I>")
keymap.set("n", "<Tab>", "<Nop>")

-- Remove original window navigation mappings to avoid conflict
keymap.del("n", "<C-h>")
keymap.del("n", "<C-j>")
keymap.del("n", "<C-k>")
keymap.del("n", "<C-l>")

-- Window navigation remapped for Dvorak layout in normal mode
local dvorak_window_nav = {
  ["<C-h>"] = "<C-w>j", -- Ctrl-h for Down
  ["<C-t>"] = "<C-w>k", -- Ctrl-t for Up
  ["<C-n>"] = "<C-w>h", -- Ctrl-n for Left
  ["<C-s>"] = "<C-w>l", -- Ctrl-s for Right
}
for key, action in pairs(dvorak_window_nav) do
  keymap.set("n", key, action)
end

-- Number increment/decrement with leader key
keymap.set("n", "<leader>+", "<C-a>", { desc = "Increment number" })
keymap.set("n", "<leader>-", "<C-x>", { desc = "Decrement number" })

-- Escape insert mode with "ht" (Dvorak version of "jk")
keymap.set("i", "ht", "<ESC>", { desc = "Exit insert mode with ht" })

-- Center cursor on half- and full-page scrolls in normal mode
local centered_scrolls = { ["<C-d>"] = "<C-d>zz", ["<C-u>"] = "<C-u>zz", ["<C-f>"] = "<C-f>zz", ["<C-b>"] = "<C-b>zz" }
for key, action in pairs(centered_scrolls) do
  keymap.set("n", key, action)
end

-- Duplicate line below/above with Alt-H and Alt-T
keymap.set("n", "<A-H>", "yyp") -- Duplicate below
keymap.set("n", "<A-T>", "yyP") -- Duplicate above

-- Open Undotree with U key
keymap.set("n", "U", "<cmd>UndotreeToggle<CR>")
