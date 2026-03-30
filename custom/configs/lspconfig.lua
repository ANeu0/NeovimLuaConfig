local on_attach = require("plugins.configs.lspconfig").on_attach
local capabilities = require("plugins.configs.lspconfig").capabilities

-- LSP CONFIGS --

-- Go
vim.lsp.config("gopls", {
  on_attach = on_attach,
  capabilities = capabilities,
  cmd = { "gopls" },
  filetypes = { "go", "gomod", "gowork", "gotmpl" },
  root_markers = { "go.work", "go.mod", ".git" },
  settings = {
    gopls = {
      completeUnimported = true,
      usePlaceholders = true,
      analyses = {
        unusedparams = true,
      },
    },
  },
})
vim.lsp.enable("gopls")

-- C#
-- local mason_path_of_DLL = vim.fn.stdpath("data") .. "//mason//packages//omnisharp//OmniSharp.dll"
-- local mason_path_of_DLL_mac = vim.fn.stdpath("data") .. "/mason/packages/omnisharp/libexec/OmniSharp.dll"
-- vim.lsp.config("omnisharp", {
--   cmd = { "dotnet", mason_path_of_DLL_mac },
--   filetypes = { "razor", "cshtml" },
--   root_markers = { "*.sln", "*.csproj", "omnisharp.json", "function.json" },
--   on_attach = on_attach,
--   capabilities = capabilities,
--   settings = {
--     FormattingOptions = { EnableEditorConfigSupport = true },
--     RoslynExtensionsOptions = { EnableDecompilationSupport = true },
--     Sdk = { IncludePrereleases = true },
--   },
-- })
-- vim.lsp.enable("omnisharp")

-- C# using csharp_ls
-- vim.lsp.config("csharp_ls", {
--   cmd = { "csharp-ls" },
--   filetypes = { "cs", "vb" },
--   root_markers = { "*.sln", "*.csproj", "omnisharp.json", "function.json" },
--   on_attach = on_attach,
--   capabilities = capabilities,
-- })
-- vim.lsp.enable("csharp_ls")

-- C# roslyn
local roslyn = require("roslyn")
roslyn.setup({
  on_attach = on_attach,
  capabilities = capabilities,
  settings = {
    ["csharp|inlay_hints"] = {
      csharp_enable_inlay_hints_for_implicit_object_creation = true,
      csharp_enable_inlay_hints_for_implicit_variable_types = true,
    },
    ["csharp|code_lens"] = {
      dotnet_enable_references_code_lens = true,
    },
    ["csharp|completion"] = {
      dotnet_show_completion_items_from_unimported_namespaces = true,
      dotnet_show_name_completion_suggestions = true,
    },
    ["csharp|formatting"] = {
      dotnet_organize_imports_on_format = true,
    },
  },
})

-- Python
vim.lsp.config("pyright", {
  on_attach = on_attach,
  capabilities = capabilities,
  filetypes = { "python" },
})
vim.lsp.enable("pyright")

-- JS/TS LSPs
local servers = { "ts_ls", "tailwindcss", "eslint", "cssls" }
for _, lsp in ipairs(servers) do
  vim.lsp.config(lsp, {
    on_attach = on_attach,
    capabilities = capabilities,
  })
  vim.lsp.enable(lsp)
end

-- Markdown
vim.lsp.config("marksman", {
  on_attach = on_attach,
  capabilities = capabilities,
  filetypes = { "markdown", "markdown.mdx", "md" },
})
vim.lsp.enable("marksman")

-- Lua
vim.lsp.config("lua_ls", {
  on_init = require("plugins.configs.lspconfig").on_init,  -- add this
  on_attach = on_attach,
  capabilities = capabilities,
  cmd = { "lua-language-server" },
  filetypes = { "lua" },
  root_markers = { { ".luarc.json", ".luarc.jsonc" }, ".git" },
  settings = {
    Lua = {
      diagnostics = {
        globals = { "vim" },
      },
      workspace = {
        library = {
          [vim.fn.expand "$VIMRUNTIME/lua"] = true,
          [vim.fn.expand "$VIMRUNTIME/lua/vim/lsp"] = true,
          [vim.fn.stdpath "data" .. "/lazy/ui/nvchad_types"] = true,
          [vim.fn.stdpath "data" .. "/lazy/lazy.nvim/lua/lazy"] = true,
        },
        maxPreload = 100000,
        preloadFileSize = 10000,
      },
    },
  },
})
vim.lsp.enable("lua_ls")
