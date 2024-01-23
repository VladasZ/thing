local M = {}

M.dap = {
  n = {
    ["<leader>db"] = {
      "<cmd> DapToggleBreakpoint <CR>",
      "Toggle breakpoint"
    },
  },
}

M.rust = {
  n = {
    ["<leader>ru"] = {
      "<cmd> RustRunnables <CR>",
      "Runnables"
    },
  },
}

return M
