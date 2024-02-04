local plugins = {
  {
   "williamboman/mason.nvim",
    opts = {
      ensure_installed = {
        "gopls",
        "pyright",
        "omnisharp",
        "lua-language-server"
      },
    },
  },
  {
    "neovim/nvim-lspconfig",
    config = function()
      require "plugins.configs.lspconfig"
      require "custom.configs.lspconfig"
    end,
  },
}
return plugins
