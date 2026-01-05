-- Debug Adapter Protocol (rustaceanvim handles Rust DAP)
return {
  "mfussenegger/nvim-dap",
  dependencies = { "rcarriga/nvim-dap-ui", "theHamsta/nvim-dap-virtual-text", "nvim-neotest/nvim-nio" },
  keys = {
    { "<F5>", function() require("dap").continue() end, desc = "Debug continue" },
    { "<F10>", function() require("dap").step_over() end, desc = "Step over" },
    { "<F11>", function() require("dap").step_into() end, desc = "Step into" },
    { "<F12>", function() require("dap").step_out() end, desc = "Step out" },
    { "<leader>b", function() require("dap").toggle_breakpoint() end, desc = "Toggle breakpoint" },
  },
  config = function()
    local dapui = require("dapui")
    dapui.setup()
    require("nvim-dap-virtual-text").setup()

    local dap = require("dap")
    dap.listeners.after.event_initialized["dapui"] = dapui.open
    dap.listeners.before.event_terminated["dapui"] = dapui.close
    dap.listeners.before.event_exited["dapui"] = dapui.close
  end,
}
