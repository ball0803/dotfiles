return {
  "williamboman/mason.nvim",
  opts = {
    ensure_installed = {
      "typescript-langauge-server",
      "rust-analyzer",
      "stylua",
      "shellcheck",
      "shfmt",
      "flake8",
    },
  },
}
