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
-- Both OmniSharp and Roslyn are used.
--  -> OmniSharp handles razor and cshtml, but poorly or not at all.
--    - Might try: https://github.com/tris203/rzls.nvim
--  -> csharp_ls handles cs as OmniSharp is no longer offically supported
local mason_path_of_DLL = vim.fn.stdpath("data") .. "//mason//packages//omnisharp//OmniSharp.dll"
lspconfig.omnisharp.setup {
  cmd = {
    "dotnet",
    mason_path_of_DLL
  },
  filetypes = { "razor", "cshtml" },
  root_dir = util.root_pattern("*.sln", "*.csproj", "omnisharp.json", "function.json"),
  on_attach = on_attach,
  capabilities = capabilities,
  settings = {
    FormattingOptions = {
      EnableEditorConfigSupport = true,
    },
    RoslynExtensionsOptions = {
      EnableDecompilationSupport = true,
    },
    Sdk = {
      IncludePrereleases = true,
    },
  },
  --   -- Sauce to figure out: https://github.com/Hoffs/omnisharp-extended-lsp.nvim
}

-- C# using csharp_ls (Roslyn-based LSP)
lspconfig.csharp_ls.setup {
  cmd = { "csharp-ls" },
  filetypes = { "cs", "vb" },
  root_dir = util.root_pattern("*.sln", "*.csproj", "omnisharp.json", "function.json"),
  on_attach = on_attach,
  capabilities = capabilities,
}

-- Python
lspconfig.pyright.setup({
  on_attach = on_attach,
  capabilities = capabilities,
  filetypes = { "python" },
})

-- JS lsps
local servers = { "tsserver", "tailwindcss", "eslint", "cssls" }

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
  filetypes = { "markdown", "markdown.mdx", "md" },
})

-- lua
lspconfig.lua_ls.setup({
  on_attach = on_attach,
  capabilities = capabilities,
  cmd = { "lua-language-server" },
  filetypes = { "lua" },
  root_markers = { { '.luarc.json', '.luarc.jsonc' }, '.git' },
  -- Specific settings to send to the server. The schema for this is
  -- defined by the server. For example the schema for lua-language-server
  -- can be found here https://raw.githubusercontent.com/LuaLS/vscode-lua/master/setting/schema.json
  settings = {
    Lua = {
      runtime = {
        version = 'LuaJIT',
      }
    }
  }
})
