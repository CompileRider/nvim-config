-- Test runner UI (rustaceanvim provides test discovery)
return {
  "nvim-neotest/neotest",
  dependencies = { "nvim-neotest/nvim-nio", "nvim-lua/plenary.nvim", "nvim-treesitter/nvim-treesitter" },
  keys = {
    { "<leader>tt", function() require("neotest").run.run() end, desc = "Run test" },
    { "<leader>tf", function() require("neotest").run.run(vim.fn.expand("%")) end, desc = "Run file" },
    { "<leader>ts", function() require("neotest").summary.toggle() end, desc = "Test summary" },
  },
  config = function()
    require("neotest").setup({ adapters = {} })
  end,
}
