local M = {}

--[[
-- For use with DAP, see plugins.lua
M.dap = {
  n = {
    ["<leader>db"] ={
      "<cmd> DapToggleBreakpoint <CR>",
      "Toggle breakpoint"
    },
  },
}
--]]

M.crates = {
  n = {
    ["<leader>rcu"] = {
      function ()
        require('crates').upgrade_all_crates()
      end,
      "update crates"
    }
  }
}

return M

