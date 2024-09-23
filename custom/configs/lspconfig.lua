local on_attach = require("plugins.configs.lspconfig").on_attach
local capabilities = require("plugins.configs.lspconfig").capabilities
local lspconfig = require("lspconfig")
local util = require "lspconfig/util"

-- LSP CONFIGS --

-- Go
lspconfig.gopls.setup {
  on_attach = on_attach,
  capabilities = capabilities,
  cmd = { "gopls" },
  filetypes = { "go", "gomod", "gowork", "gotmpl" },
  root_dir = util.root_pattern("go.work", "go.mod", ".git"),
  settings = {
    completeUnimported = true,
    usePlaceholders = true,
    analyses = {
      unusedparams = true,
    },
  },
}

-- C#
-- this one is janky, need to specify .dll file path
local mason_package_path = vim.fn.stdpath("data")
lspconfig.omnisharp.setup {
  -- Sauce: https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#omnisharp
  cmd = { "dotnet", mason_package_path .. "/mason/packages/omnisharp/libexec/OmniSharp.dll" },
  on_attach = on_attach,
  capabilities = capabilities,
  -- Sauce to figure out: https://github.com/Hoffs/omnisharp-extended-lsp.nvim
}

-- Python
lspconfig.pyright.setup({
  on_attach = on_attach,
  capabilities = capabilities,
  filetypes = { "python" },
})

-- Rust
-- commenting out as is handled by rust-tools
-- found in plugins.lua
--[[
lspconfig.rust_analyzer.setup({
  on_attach = on_attach,
  capabilities = capabilities,
  filetypes = { "rust" },
  root_dir = util.root_pattern("Cargo.toml"),
  settings = {
    ['rust-analyzer'] = {
      cargo = {
        allFeatures = true,
      },
    },
  },
})
]]--

-- JS lsps
local servers = {"tsserver", "tailwindcss", "eslint", "cssls"}

for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup {
  on_attach = on_attach,
  capabilities = capabilities,
  }
end
-- markdown
lspconfig.marksman.setup({
  on_attach = on_attach,
  capabilities = capabilities,
  filetypes = { "markdown", "markdown.mdx" },
})
