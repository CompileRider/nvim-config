-------------------------------------------------------------------------------
-- Fun plugins (local only)
-------------------------------------------------------------------------------
return {
  -- Cellular automaton animation
  {
    "eandrju/cellular-automaton.nvim",
    keys = {
      { "<leader>fml", "<cmd>CellularAutomaton make_it_rain<cr>", desc = "Make it rain" },
      { "<leader>gol", "<cmd>CellularAutomaton game_of_life<cr>", desc = "Game of life" },
    },
  },
  -- Duck companion
  {
    "tamton-aquib/duck.nvim",
    keys = {
      { "<leader>dd", function() require("duck").hatch("🦆") end, desc = "Hatch duck" },
      { "<leader>dk", function() require("duck").cook() end, desc = "Cook duck" },
      { "<leader>da", function() require("duck").cook_all() end, desc = "Cook all" },
    },
  },
}
