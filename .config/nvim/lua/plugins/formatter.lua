return {
    "stevearc/conform.nvim",
    event = { "BufreadPre", "BufNewFile" },
    config = function()
        local conform = require("conform")

        conform.setup({
            formatters_by_ft = {
                javascript = { "prettier" },
                typescript = { "prettier" },
                css = { "prettier" },
                html = { "prettier" },
                python = { "isort", "black" },
                lua = { "stylua" },
                go = { "gofmt" },
            },
            format_on_save = {
                lsp_follback = true,
                async = false,
                timeout_ms = 500,
            },
        })

        vim.keymap.set({ "n", "v" }, "<leader>mp", function()
            conform.format({
                lsp_follback = true,
                async = false,
                timeout_ms = 500,
            })
        end, { desc = "Format file or range (visual mode)" })
    end,
}
