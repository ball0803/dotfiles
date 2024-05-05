local on_attach = require("plugins.lspconfig.lspconfig").on_attach
local capabilities = require("plugins.lspconfig.lspconfig").capabilities
local lspconfig = require("lspconfig")
local util = require "lspconfig/util"

lspconfig.tsserver.setup({
  init_options = {
    preferences = {
      disableSuggestions = true,
    },
  },
})

lspconfig.rust_analyzer.setup({
  on_attach = on_attach,
  capabilities = capabilities,
  filetypes = { "rust" },
  root_dir = util.root_pattern("Cargo.toml"),
  settings = {
    ['rust-analyzer'] = {
      cargo = {
        allFeatures = true,

      }
    }
  }

})
