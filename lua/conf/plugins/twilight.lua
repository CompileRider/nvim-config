-------------------------------------------------------------------------------
-- Twilight - Focus mode
-- Dims inactive code to highlight current scope
-------------------------------------------------------------------------------
return {
  "folke/twilight.nvim",
  keys = { { "<leader>tw", "<cmd>Twilight<cr>", desc = "Toggle Twilight" } },
  opts = {
    dimming = { alpha = 0.4 },
    context = 15,
    treesitter = true,
    expand = { "function", "method", "table", "if_statement", "for_statement", "while_statement" },
  },
}
