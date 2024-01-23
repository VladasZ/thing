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
      "Runnables."
    },
    ["<leader>ex"] = {
      "<cmd> RustExpandMacro <CR>",
      "Expand rust macro."
    },
  },
}

return M
