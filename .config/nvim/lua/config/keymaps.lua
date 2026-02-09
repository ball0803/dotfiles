-- Leader key
vim.g.mapleader = " "
local keymap = vim.keymap

-----------------------------------------------------------
-- Remove default conflicting mappings
-----------------------------------------------------------
keymap.del("n", "H")
keymap.del("n", "L")

-- Remove original window navigation
keymap.del("n", "<C-h>")
keymap.del("n", "<C-j>")
keymap.del("n", "<C-k>")
keymap.del("n", "<C-l>")

-----------------------------------------------------------
-- Buffer navigation
-----------------------------------------------------------
keymap.set("n", "N", ":BufferLineCyclePrev<CR>", { silent = true })
keymap.set("n", "S", ":BufferLineCycleNext<CR>", { silent = true })

-----------------------------------------------------------
-- Save
-----------------------------------------------------------
keymap.del({ "n", "x", "i", "s" }, "<C-s>")
keymap.set("n", "<leader>s", "<cmd>w<CR>", { desc = "Save file" })

-----------------------------------------------------------
-- Search navigation
-----------------------------------------------------------
keymap.set("n", "<M-n>", "n", { silent = true })
keymap.set("n", "<M-N>", "N", { silent = true })

-----------------------------------------------------------
-- htsn: Cursor navigation (Normal + Visual)
-- h = down | t = up | s = left | n = right
-----------------------------------------------------------
local htsn_nav = {
    h = "j",
    t = "k",
    s = "h",
    n = "l",
}

for key, action in pairs(htsn_nav) do
    keymap.set({ "n", "v" }, key, action, { noremap = true })
end

-----------------------------------------------------------
-- htsn: Insert-mode arrow navigation
-----------------------------------------------------------
local insert_htsn_nav = {
    ["<C-h>"] = "<Down>",
    ["<C-t>"] = "<Up>",
    ["<C-s>"] = "<Left>",
    ["<C-n>"] = "<Right>",
}

for key, action in pairs(insert_htsn_nav) do
    keymap.set("i", key, action, { noremap = true })
end

-----------------------------------------------------------
-- htsn: Window navigation
-----------------------------------------------------------
local window_htsn_nav = {
    ["<C-h>"] = "<C-w>j",
    ["<C-t>"] = "<C-w>k",
    ["<C-s>"] = "<C-w>h",
    ["<C-n>"] = "<C-w>l",
}

for key, action in pairs(window_htsn_nav) do
    keymap.set("n", key, action, { noremap = true })
end

-----------------------------------------------------------
-- Disable Tab, keep Ctrl-I jump
-----------------------------------------------------------
keymap.set("n", "<C-I>", "<C-I>")
keymap.set("n", "<Tab>", "<Nop>")

-----------------------------------------------------------
-- Number increment / decrement
-----------------------------------------------------------
keymap.set("n", "<leader>+", "<C-a>", { desc = "Increment number" })
keymap.set("n", "<leader>-", "<C-x>", { desc = "Decrement number" })

-----------------------------------------------------------
-- Insert escape (htsn-friendly)
-----------------------------------------------------------
keymap.set("i", "ht", "<ESC>", { desc = "Exit insert mode with ht" })

-----------------------------------------------------------
-- Center cursor on scroll
-----------------------------------------------------------
local centered_scrolls = {
    ["<C-d>"] = "<C-d>zz",
    ["<C-u>"] = "<C-u>zz",
    ["<C-f>"] = "<C-f>zz",
    ["<C-b>"] = "<C-b>zz",
}

for key, action in pairs(centered_scrolls) do
    keymap.set("n", key, action)
end

-----------------------------------------------------------
-- Duplicate line
-----------------------------------------------------------
keymap.set("n", "<A-h>", "yyp", { desc = "Duplicate line below" })
keymap.set("n", "<A-t>", "yyP", { desc = "Duplicate line above" })

-----------------------------------------------------------
-- UndoTree
-----------------------------------------------------------
keymap.set("n", "U", "<cmd>UndotreeToggle<CR>")

-----------------------------------------------------------
-- Diagnostics
-----------------------------------------------------------
keymap.set("n", "<leader>d", vim.diagnostic.open_float, {
    desc = "Show diagnostic under cursor",
})
