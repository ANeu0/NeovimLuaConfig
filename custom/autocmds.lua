-- Create a group to prevent duplicate autocommands on reload
local augroup = vim.api.nvim_create_augroup("CustomAutoCmds", { clear = true })

-- Set proper filetype for Razor and CSHTML files
vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
  group = augroup,
  pattern = { "*.razor", "*.cshtml" },
  callback = function()
    vim.bo.filetype = "razor" -- or "cshtml" if you prefer
  end,
})

-- Example: turn on spellcheck in markdown and text files
vim.api.nvim_create_autocmd("FileType", {
  group = augroup,
  pattern = { "markdown", "text" },
  callback = function()
    vim.opt_local.spell = true
  end,
})

-- Example: remove trailing whitespace on save
vim.api.nvim_create_autocmd("BufWritePre", {
  group = augroup,
  pattern = "*",
  callback = function()
    vim.cmd([[%s/\s\+$//e]])
  end,
})
