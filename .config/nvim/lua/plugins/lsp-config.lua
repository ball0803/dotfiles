return {

    {
        "mason-org/mason.nvim",
        lazy = false,
        config = function()
            require("mason").setup({
                pip = "py -m pip",
            })
        end,
        opts = {
            ensure_installed = {
                "typescript-langauge-server",
                "rust-analyzer",
                "stylua",
                "shellcheck",
                "shfmt",
                "flake8",
                "black",
                "pyright",
                "gopls",
            },
        },
    },
    {
        "mason-org/mason-lspconfig.nvim",
        lazy = false,
        opts = {
            auto_install = true,
        },
    },
    {
        "neovim/nvim-lspconfig",
        lazy = false,
        config = function()
            local capabilities = require("cmp_nvim_lsp").default_capabilities()
            local util = require("lspconfig/util")
            local lspconfig = require("lspconfig")

            lspconfig.html.setup({
                capabilities = capabilities,
            })

            lspconfig.lua_ls.setup({
                capabilities = capabilities,
            })

            lspconfig.tsserver.setup({
                capabilities = capabilities,
                init_options = {
                    preferences = {
                        disableSuggestions = true,
                    },
                },
            })

            lspconfig.gopls.setup({
                capabilities = capabilities,
                cmd = { "gopls" },
                filetypes = { "go", "gomod", "gowork", "gotmpl" },
                root_dir = util.root_pattern("go.work", "go.mod", ".git"),
            })

            lspconfig.rust_analyzer.setup({
                capabilities = capabilities,
                filetypes = { "rust" },
                root_dir = util.root_pattern("Cargo.toml"),
                settings = {
                    ["rust-analyzer"] = {
                        cargo = {
                            allFeatures = true,
                        },
                    },
                },
            })

            lspconfig.pyright.setup({
                cmd = { "py", "-m", "pyright-langserver", "--stdio" },
                capabilities = capabilities,
                filetypes = { "python" },
                root_dir = util.root_pattern("pyproject.toml", "setup.py", "setup.cfg", "requirements.txt", ".git"),
                setting = {
                    python = {
                        pythonPath = "py",
                    },
                },
            })

            vim.keymap.set("n", "K", vim.lsp.buf.hover, {})
            vim.keymap.set("n", "gd", vim.lsp.buf.definition, {})
            vim.keymap.set("n", "gr", vim.lsp.buf.references, {})
            vim.keymap.set("n", "ca", vim.lsp.buf.code_action, {})
        end,
    },
}
