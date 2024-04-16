local plugins = {
  {
    "williamboman/mason.nvim",
    opts = {
      ensure_installed = {
        "gopls",
        "pyright",
        "omnisharp",
        "rust-analyzer",
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
  {
    "rust-lang/rust.vim",
    ft = "rust",
    init = function()
      vim.g.rustfmt_autosave = 1
    end
  },
  {
    -- Rust LSP
    "simrat39/rust-tools.nvim",
    ft = "rust",
    dependencies = "neovim/nvim-lspconfig",
    opts = function()
      return require "custom.configs.rust-tools"
    end,
    config = function(_, opts)
      require('rust-tools').setup(opts)
    end
  },
  --[[
  --Debbuger: https://github.com/mfussenegger/nvim-dap
  --commented out due to windows skill issues, use with: https://lldb.llvm.org/resources/build.html
  {
    "mfussenegger/nvim-dap",
  }
  ]]--
  {
    -- Info for Rust crates
    'saecki/crates.nvim',
    ft ={ "rust", "toml" },
    config = function (_, opts)
      local crates = require('crates')
      crates.setup(opts)
      crates.show()
    end,
  },
  {
    -- Autocomplete for Rust Crates
    "hrsh7th/nvim-cmp",
    opts = function ()
      local M = require "plugins.configs.cmp"
      table.insert(M.sources, {name = "crates"})
      return M
    end,
  }

}
return plugins
