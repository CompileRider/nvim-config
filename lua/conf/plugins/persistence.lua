return {
  "folke/persistence.nvim",
  event = "BufReadPre",
  keys = {
    { "<leader>qs", function() require("persistence").load() end, desc = "Load session for current dir" },
    { "<leader>qS", function() require("persistence").select() end, desc = "Select session to load" },
    { "<leader>ql", function() require("persistence").load({ last = true }) end, desc = "Load last session" },
    { "<leader>qd", function() require("persistence").stop() end, desc = "Stop session recording" },
  },
  opts = {
    dir = vim.fn.stdpath("state") .. "/sessions/",
    need = 1,
    branch = true,
  },
}
