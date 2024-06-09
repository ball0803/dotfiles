return {
  'ThePrimeagen/harpoon',
  dependencies = {
    'nvim-lua/plenary.nvim',
  },
  config = function()
    local keymap = vim.keymap -- for conciseness
    local ui = require("harpoon.ui")

    keymap.set("n", "hx", require("harpoon.mark").add_file)
    keymap.set("n", "hn", ui.nav_next)
    keymap.set("n", "hp", ui.nav_prev)
    keymap.set("n", "<leader>hm", "<cmd>Telescope harpoon marks<CR>")
    keymap.set("n", "<leader>hM", ui.toggle_quick_menu)
    keymap.set("n", "<a-1>", function() ui.nav_file(1) end)
    keymap.set("n", "<a-2>", function() ui.nav_file(2) end)
    keymap.set("n", "<a-3>", function() ui.nav_file(3) end)
    keymap.set("n", "<a-4>", function() ui.nav_file(4) end)
  end
}
